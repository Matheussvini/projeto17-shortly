import { Router } from "express";
import { createShortLink, deleteShortLink, findById, openShortLink } from "../controllers/urls.controllers.js";
import authValidation from "../middlewares/authValidation.js";
import { validShemaDelete, validShemaShortLink, validShortlink } from "../middlewares/urls.middlewares.js";


const router = Router();

router.get('/urls/:id', findById);
router.get('/urls/open/:shortUrl', validShortlink, openShortLink);

router.use(authValidation);

router.post('/urls/shorten', validShemaShortLink, createShortLink);
router.delete('/urls/:id', validShemaDelete, deleteShortLink);


export default router;