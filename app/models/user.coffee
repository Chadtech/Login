mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema {username: String, password: String, numberOfLogins: Number}

module.exports = mongoose.model 'User', UserSchema