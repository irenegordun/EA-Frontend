import { Schema, model } from 'mongoose';

const User = new Schema({
	name: String,
	password: String,
	email: String
});

export default model('User', User);