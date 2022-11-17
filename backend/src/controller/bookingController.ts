import Booking from '../model/Booking';
import User from '../model/User';
import { Request, Response } from 'express';

const booking = async (req: Request, res: Response) => {
	const user = req.body.user;
	const name = req.body.name;
	const user1 = await User.findOne({ name: user });
	if (!user1) {
		return res.status(400).json({ message: 'User not found' });
	}
	const newBooking = new Booking({
		name,
		user: user1._id
	});
	await newBooking.save();
	res.status(200).json({ auth: true });
};

const cancel = async (req: Request, res: Response) => {
	const name = req.body.name;
	const userID = req.body.user;
	const findbooking = await Booking.findOne({ name, user: userID });
	if (!findbooking) {
		return res.status(400).json({ message: 'Booking not found' });
	}
	await Booking.findByIdAndDelete(findbooking._id);
	res.status(200).json({ auth: true });
};

const getall = async (req: Request, res: Response) => {
	const bookings = await Booking.find().populate('user');
	res.json(bookings);
};

export default {
	booking,
	cancel,
	getall
};