import { Router } from "express";
import { findRanking } from "../controllers/ranking.controllers.js";

const router = Router();

router.get("/ranking", findRanking);

export default router;
