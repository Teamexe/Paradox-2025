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


module.exports=router;