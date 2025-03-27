const express=require('express');
const router=express.Router();
const {QuestionConroller}=require('../../controllers')
const {ValidateAuthReq}=require('../../middlewares');


router.patch('/next',ValidateAuthReq.checkAuth,QuestionConroller.nextQues);
router.get('/current',ValidateAuthReq.checkAuth,QuestionConroller.currentQues);
router.post('/add',QuestionConroller.addQues);
router.get('/getAll',QuestionConroller.getAll);
router.delete('/delete/:id',QuestionConroller.deleteQues);
router.patch('/update/:id',QuestionConroller.updateQues);



module.exports=router;