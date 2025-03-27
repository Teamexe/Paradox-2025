// const express =require('express');
// const { AuthController } = require('../../controllers');
// const {ValidateAuthReq}=require('../../middlewares');

// const router=express.Router();

// router.post('/signup',ValidateAuthReq.validateAuthRequest,AuthController.signUp);
// router.post('/signIn',ValidateAuthReq.validateAuthRequest,AuthController.signIn);



// module.exports=router;




const passport = require('passport');
const { Strategy: GoogleStrategy } = require('passport-google-oauth20');
const {AuthService} = require('../../services');
const { SuccessResponse, ErrorResponse } = require('../../utils/common');
const { StatusCodes } = require('http-status-codes');
const express = require('express');
const router = express.Router();

passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID ,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/api/v1/auth/google/callback', // Ensure this matches Google console
}, async (accessToken, refreshToken, profile, done) => {
    try {
        const user = await AuthService.findOrCreateUser(profile);
        return done(null, user);
    } catch (err) {
        return done(err, null);
    }
}));


passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
    try {
        const user = await AuthService.findUserById(id);
        done(null, user);
    } catch (err) {
        done(err, null);
    }
});

router.get('/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

router.get('/google/callback', passport.authenticate('google', { failureRedirect: '/' }), async (req, res) => {
    try {
        const token = await AuthService.generateToken(req.user);
        SuccessResponse.data = { user: req.user, token };
        SuccessResponse.message = 'User authenticated successfully';
        return res.status(StatusCodes.OK).json(SuccessResponse);
    } catch (error) {
        console.error(error);
        ErrorResponse.error = error;
        return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse);
    }
});

module.exports = router;
