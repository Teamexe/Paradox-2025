require('dotenv').config();
module.exports = {
    MONGODB_URI: process.env.DB_URI || 'mongodb://127.0.0.1:27017/paradox'
}