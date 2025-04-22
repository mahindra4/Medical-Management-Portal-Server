const express = require("express");
const cors = require("cors");
const cookieParser = require("cookie-parser");
require("dotenv").config();
//prisma client
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const app = express();

const port = process.env.PORT || 4000;



app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(cookieParser());

//TODO: Change the origin to deployed frontend URL
app.use(cors({
    origin: "http://localhost:5173",
    credentials: true
}));

app.get('/',(req, res) => res.send('hello world'));

app.listen(port, () => {
  console.log("Server is running on port 4000");
});


module.exports = app;