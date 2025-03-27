const {QuestionRepository} = require('../repositories');
const AppError = require('../utils/errors/appError');
const { StatusCodes } = require('http-status-codes');
const {AuthRepository} = require('../repositories');
const { response } = require('express');
const AuthRepo=new AuthRepository();
const quesRepo=new QuestionRepository();
const {serverConfig}=require('../config')

async function nextQues(answer,userId){
    try {
        const user=await AuthRepo.findUserById(userId);
        console.log('User:',user);
        const isCorrect=await quesRepo.verifyQuestion(user.currQues,answer);

       
        if(user.currQues===await(quesRepo.lastQues())){
            const response="Level is finished";
            return response;
        }
        if(isCorrect){
            const newQues=await quesRepo.nextQues(user.currQues,user.currLvl);
            const updateUser=await AuthRepo.update(userId,{currQues:newQues.id,score:((user.score)+serverConfig.SCORE)});
            console.log('updatedUser',updateUser);
            return newQues;
        }
    } catch (error) {
        console.log(error);
        throw new AppError(error,StatusCodes.BAD_REQUEST);
    }
}


async function addQues(data) {
    try {
        const lastQues=(await quesRepo.lastQues()) || 0;
        const id=(lastQues)+1;
        data.id=id
        console.log("data",data)
        const response=await quesRepo.create(data);
        console.log("response of add ques:",response);
        return response;
    } catch (error) {
        console.log(error);
        throw new AppError(error,StatusCodes.BAD_REQUEST);
    }
}


async function currentQues(user) {
    try {
        const query={ lvl: user.currLvl, id: user.currQues };
        const reponse=await quesRepo.getAll(query);
        console.log("Current Quest:",reponse);
        return reponse || null;
    } catch (error) {
        console.log(error);
        throw new AppError(error,StatusCodes.BAD_REQUEST);
    }
}


module.exports={nextQues,addQues,currentQues};