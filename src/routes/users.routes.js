import { Router } from "express";
import { createUser, findById, login } from "../controllers/users.controllers.js";
import authValidation from "../middlewares/authValidation.js";
import { validShemaSignIn, validShemaSignUp } from "../middlewares/users.middlewares.js";

const router = Router();

router.post('/signup', validShemaSignUp, createUser);
router.post('/signin', validShemaSignIn, login);
router.get('/users/me', authValidation , findById);

export default router;
