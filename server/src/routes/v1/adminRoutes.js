const express =require('express');
const { AdminController } = require('../../controllers');

const router=express.Router();


router.post('/signIn',AdminController.signIn);
router.post('/changeLevel',AdminController.changeLevel);

module.exports=router;