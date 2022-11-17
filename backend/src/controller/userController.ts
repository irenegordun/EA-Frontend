import User from '../model/User';
import jwt from 'jsonwebtoken';
import CryptoJS from 'crypto-js';
import { Request, Response } from 'express';

const register = async (req: Request, res: Response) => {
	const name = req.body.name;
	const email = req.body.email;
	const password = CryptoJS.AES.encrypt(req.body.password, 'secret key 123').toString();
	const newUser = new User({ name, password, email });
	await newUser.save();
	const token = jwt.sign({ id: newUser._id }, 'yyt#KInN7Q9X3m&$ydtbZ7Z4fJiEtA6uHIFzvc@347SGHAjV4E', {
		expiresIn: 60 * 60 * 24
	});
	res.status(200).json({ auth: true, token });
};

const login = async (req: Request, res: Response) => {
	const user = await User.findOne({ email: req.body.email });
	if (!user) {
		return res.status(404).send('The email does not exist');
	}
	const validPassword = CryptoJS.AES.decrypt(user.password, 'secret key 123').toString(CryptoJS.enc.Utf8);
	if (!validPassword) {
		return res.status(401).json({ auth: false, token: null });
	}
	const token = jwt.sign({ id: user._id }, 'yyt#KInN7Q9X3m&$ydtbZ7Z4fJiEtA6uHIFzvc@347SGHAjV4E', {
		expiresIn: 60 * 60 * 24
	});
	res.json({ auth: true, token });
};

const profile = async (req: Request, res: Response) => {
	const user = await User.findById(req.params.userId, { password: 0 });
	if (!user) {
		return res.status(404).send('No user found.');
	}
	res.json(user);
};

const getall = async (req: Request, res: Response) => {
	const users = await User.find();
	res.json(users);
};

const getone = async (req: Request, res: Response) => {
	const user = await User.findById(req.params.id);
	res.json(user);
};

const changePass = async (req: Request, res: Response) => {
	const user = await User.findById(req.params.id);
	if (!user) {
		return res.status(404).send('No user found.');
	}
	if (req.body.password === CryptoJS.AES.decrypt(user.password, 'secret key 123').toString(CryptoJS.enc.Utf8)) {
		let newpassword = req.body.newpassword;
		newpassword = CryptoJS.AES.encrypt(newpassword, 'secret key 123').toString();
		user.password = newpassword;
		await user.save();
		res.json({ status: 'User Updated' });
	}
	else {
		res.json({ status: 'Wrong password' });
	}
};

const remove = async (req: Request, res: Response) => {
	try {
		const user = await User.findOneAndDelete({ name: req.params.name }).catch(Error);
		console.log(user);
		// await User.deleteOne(user);
		res.status(200).json({ status: 'User deleted' });
	}
	catch (err) {
		res.status(500).json({ message: 'User not found', err });
	}
};
const updateUser = async (req: Request, res: Response) => {
	try {
		const user = await User.findOne({ name: req.params.name });
		if (!user) {
			return res.status(404).send('No user found.');
		}
		let newpassword = req.body.password;
		const newemail = req.body.email;
		newpassword = CryptoJS.AES.encrypt(newpassword, 'secret key 123').toString();
		user.password = newpassword;
		user.email = newemail;
		await user.save();
		res.json({ status: 'User Updated' });
	}
	catch (err) {
		res.status(500).json({ message: 'User not found', err });
	}

}

export default {
	register,
	login,
	profile,
	getall,
	getone,
	changePass,
	remove,
	updateUser
};