const express=require('express');
const router=express.Router();
const authRoutes=require('./authRoutes')
const HomeRoute=require('./homeRoutes')
const app=express();


app.use('/',HomeRoute)
app.use('/auth', authRoutes);
// app.use('/quiz', quizRoutes);
// app.use('/leaderboard', leaderboardRoutes);

module.exports=app;
