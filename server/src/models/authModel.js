const mongoose=require('mongoose');
const bcrypt=require('bcryptjs')


const Schema=mongoose.Schema
const userSchema= new Schema({
    name:{
        type:String,
        require:true
    },
    email:{
        type:String,
        require:true
    },
    password:{
        type:String,
        require:true
    },
    score:{
        type:Number,
        default: 0
    },
    level2:{
        type:Boolean,
        default:0
    }
},{
    timestamps:true
})


userSchema.pre('save',async function(next){
    const user=this;
    if(user.isModified('password')){
        user.password=await bcrypt.hash(user.password,10);
    }
    next();
})


const User=mongoose.model('User',userSchema);
module.exports=User;