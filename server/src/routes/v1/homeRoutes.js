const express=require('express');

const router=express.Router();
const {ValidateAuthReq}=require('../../middlewares');
const { StatusCodes } = require('http-status-codes');



router.get('/home',ValidateAuthReq.checkAuth,async (req,res)=>{
    try {
        const user=req.user;
        
        console.log(user);
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }
        return res.status(StatusCodes.ACCEPTED).json(user);
    } catch (error) {
        console.error('Error fetching user:', error);
        return res.status(StatusCodes.BAD_REQUEST).json({ error: 'Internal server error' });
    }
})

router.get('/score',ValidateAuthReq.checkAuth,async(req,res)=>{
    try {
        const user=req.user;
        console.log("user:",user);
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }
        const ogScore=user.score;
        const hintUsed = Array.isArray(user.hintUsed) ? user.hintUsed.length : 0;
        const response.data= ogScore - (hintUsed * 20);
        console.log(ogScore,hintUsed)
        return res.status(StatusCodes.ACCEPTED).json(response);
    } catch (error) {
        console.error('Error fetching user:', error);
        return res.status(StatusCodes.BAD_REQUEST).json({ error: 'Internal server error' });
    }
});


module.exports=router;
