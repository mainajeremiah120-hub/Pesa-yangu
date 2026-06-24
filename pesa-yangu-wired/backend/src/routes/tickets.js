"use strict";
const express = require("express");
const { query } = require("../models/db");
const router  = express.Router();

// GET /tickets — user's own tickets
router.get("/", async (req, res, next) => {
  try {
    const { rows } = await query(
      `SELECT id, subject, category, status, priority, message, admin_reply, replied_at, created_at, updated_at
       FROM support_tickets WHERE user_id=$1 ORDER BY created_at DESC`,
      [req.user.id]
    );
    res.json({ tickets: rows });
  } catch (err) { next(err); }
});

// POST /tickets — raise a new ticket
router.post("/", async (req, res, next) => {
  try {
    const { subject, message, category = "general" } = req.body;
    if (!subject?.trim()) return res.status(400).json({ error: "Subject is required" });
    if (!message?.trim()) return res.status(400).json({ error: "Message is required" });
    const { rows: [ticket] } = await query(
      `INSERT INTO support_tickets (user_id, subject, message, category)
       VALUES ($1,$2,$3,$4) RETURNING *`,
      [req.user.id, subject.trim(), message.trim(), category]
    );
    res.status(201).json({ ticket });
  } catch (err) { next(err); }
});

module.exports = router;
