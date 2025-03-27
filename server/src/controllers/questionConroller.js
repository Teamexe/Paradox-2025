const { response } = require("express");
const {ErrorResponse,SuccessResponse}=require("../utils/common");
const {StatusCodes}=require('http-status-codes')
const {QuestionService}=require('../services')
const {AppError}=require('../utils/errors/appError')


async function nextQues(req,res) {
    try {
        const {answer}=req.body;
        const userId = req.user.id;
        if(!answer){
            ErrorResponse.message='Answer is required';
            return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse);
        }
        const reponse=await QuestionService.nextQues(answer,userId);
        if(!reponse){
            ErrorResponse.message=`Cant get there:${response.message}`;
            return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse);
        }
        SuccessResponse.message="Next Question fetch Successfully";
        SuccessResponse.data=reponse;
        return res.status(StatusCodes.ACCEPTED).json(SuccessResponse);
    } catch (error) {
        console.log(error);
        ErrorResponse.message="Something went wrong while getting next question";
        ErrorResponse.error=error;
        return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse);
    }
}


async function addQues(req,res) {
    try {
        const { lvl, title, descriptionOrImgUrl, hint, answer } = req.body;
        if (!lvl || !answer) {
            throw new AppError("lvl and answer are required", StatusCodes.BAD_REQUEST);
        }
        const data = {
            lvl,
            title,
            descriptionOrImgUrl,
            hint: hint|| "No Hint In This Question",
            answer
        };
        console.log("Adding Question data:",data)
        const reponse=await QuestionService.addQues(data);
        return res.status(StatusCodes.ACCEPTED).json(reponse);
    } catch (error) {
        console.log(error);
        ErrorResponse.message="Something went wrong while adding Question"
        ErrorResponse.error=error;
        return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse);
    }
}

async function currentQues(req,res) {
    try {
        const user=req.user;
        console.log(user)
        if(!user){
            ErrorResponse.message='UserId is required';
            return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse)
        }
        const response=await QuestionService.currentQues(user);
        return res.status(StatusCodes.ACCEPTED).json(response);
    } catch (error) {
        console.log(error);
        ErrorResponse.message="Something went wrong while fetching Question";
        ErrorResponse.error=error;
        return res.status(StatusCodes.BAD_REQUEST).json(ErrorResponse);
    }
}

module.exports={
    nextQues,
    addQues,
    currentQues
}