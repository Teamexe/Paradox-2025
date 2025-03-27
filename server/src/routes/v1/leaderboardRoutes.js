const express=require('express')
const router=express.Router();
const {User}=require('../../models')

router.get("/leaderboard-stream", async (req, res) => {
    res.setHeader("Content-Type", "text/event-stream");
    res.setHeader("Cache-Control", "no-cache");
    res.setHeader("Connection", "keep-alive");

    const sendLeaderboard = async () => {
        const leaderboard = await User.find().sort({ score: -1 }).limit(100);
        res.write(`data: ${JSON.stringify(leaderboard)}\n\n`);
    };

    sendLeaderboard();

    const changeStream = User.watch();

    changeStream.on("change", async (change) => {
        if (change.operationType === "update" || change.operationType === "insert") {
            sendLeaderboard(); 
        }
    });

    req.on("close", () => {
        changeStream.close();
        res.end();
    });
});


module.exports=router;
