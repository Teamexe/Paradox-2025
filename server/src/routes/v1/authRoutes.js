const express =require('express');
const { AuthController } = require('../../controllers');
const {ValidateAuthReq}=require('../../middlewares');

const router=express.Router();

router.post('/signup',ValidateAuthReq.validateAuthRequest,AuthController.signUp);
router.post('/signIn',ValidateAuthReq.validateAuthRequest,AuthController.signIn);



module.exports=router;