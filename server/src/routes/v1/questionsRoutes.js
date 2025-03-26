const express=require('express');
const router=express.Router();
const {QuestionConroller}=require('../../controllers')
const {ValidateAuthReq}=require('../../middlewares');


router.patch('/next',ValidateAuthReq.checkAuth,QuestionConroller.nextQues);
// router.get('/current',ValidateAuthReq.checkAuth,QuestionConroller.currentQues);
router.post('/add',QuestionConroller.addQues);
// router.delete('/delete',QuestionConroller.deleteQues);
// router.patch('/update',QuestionConroller.updateQues);



module.exports=router;