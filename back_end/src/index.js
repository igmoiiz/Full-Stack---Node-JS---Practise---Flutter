const express = require("express");
const mongoose = require("mongoose");

const Practise = require("./Models/practise_model");
const bodyParser = require("body-parser");
const app = express();
const cors = require("cors");
app.use(cors());
const PORT = 5000;

// Middleware to parse JSON bodies
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: false }));

mongoose
  .connect(
    "mongodb+srv://khanmoaiz682:332211Asdfghjkl@practise.k7nry.mongodb.net/practiseDB"
  )
  .then(() => {
    console.log("Database Connection Successful!");

    // Route for data page
    app.get("/", async (req, res) => {
      try {
        const data = await Practise.find();
        res.json(data);
      } catch (error) {
        console.error(error);
        res.status(500).send("Error Occurred while Fetching Data!");
      }
    });

    // Route for pushing data
    app.post("/post", async (req, res) => {
      try {
        // Check if the ID already exists
        const existingPractise = await Practise.findOne({ id: req.body.id });
        if (existingPractise) {
          return res.status(400).json({ message: "ID already exists" });
        }
        const { id, name, email } = req.body;
        const newPractise = new Practise({ id, name, email });

        await newPractise.save();
        const response = { message: "Data Posted Successfully!" };
        res.status(201).json(response);
      } catch (error) {
        console.error(error);
        res.status(500).send("Error While Posting Data");
      }
    });

    // Route for updating data
    app.put("/update/:id", async (req, res) => {
      try {
        const id = req.params.id;
        const existingPractise = await Practise.findById(id);
        if (!existingPractise) {
          return res.status(404).json({ message: "ID not found" });
        }
        const { name, email } = req.body;
        existingPractise.name = name;
        existingPractise.email = email;

        await existingPractise.save();
        const response = { message: "Data Updated Successfully!" };
        res.status(200).json(response);
      } catch (error) {
        console.error(error);
        res.status(500).send("Error While Updating Data");
      }
    });

    // Route for deleting data
    app.delete("/delete/:id", async (req, res) => {
      try {
        const id = req.params.id;
        const existingPractise = await Practise.findByIdAndDelete(id);
        if (!existingPractise) {
          return res.status(404).json({ message: "ID not found" });
        }
        const response = { message: "Data Deleted Successfully!" };
        res.status(200).json(response);
      } catch (error) {
        console.error(error);
        res.status(500).send("Error While Deleting Data");
      }
    });

    app.listen(PORT, "0.0.0.0", () => {
      console.log(`Server is running on port ${PORT}`);
    });
  })
  .catch((error) => {
    console.error("Database connection error:", error);
  });
