const mongoose = require("mongoose");

const practiseSchema = mongoose.Schema({
  id: {
    required: true,
    unique: true,
    type: String,
  },
  name: {
    required: true,
    type: String,
  },
  email: {
    required: true,
    type: String,
  },
});

module.exports = mongoose.model("Practise", practiseSchema);
