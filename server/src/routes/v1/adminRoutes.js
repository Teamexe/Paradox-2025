const express =require('express');
const { AdminController } = require('../../controllers');

const router=express.Router();


router.post('/signIn',AdminController.signIn);

module.exports=router;