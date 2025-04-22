const ExpressError = require("./utils/ExpressError");
const {
  medicineSchema,
  supplierSchema,
  staffSchema,
  scheduleSchema,
  stockSchema,
  patientSchema,
  purchaseListSchema,
  purchaseSchema,
  categorySchema,
  sendOtpSchema,
  verifyOtpSchema,
  userSchema,
  checkupSchema,
  feedbackSchema,
  observationItemSchema
} = require("./schemas");

// Validation middleware functions
module.exports.validateMedicine = (req, res, next) => {
  const { error } = medicineSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateSupplier = (req, res, next) => {
  const { error } = supplierSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateStaff = (req, res, next) => {
  const { error } = staffSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateSchedule = (req, res, next) => {
  const { error } = scheduleSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateStock = (req, res, next) => {
  const { error } = stockSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validatePatient = (req, res, next) => {
  const { error } = patientSchema.validate(req.body);
  console.log("Validating patient details");
  handleValidationError(error, next);
};

module.exports.validatePurchaseList = (req, res, next) => {
  const { error } = purchaseListSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validatePurchase = (req, res, next) => {
  const { error } = purchaseSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateCategory = (req, res, next) => {
  const { error } = categorySchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateCheckup = (req, res, next) => {
  const { error } = checkupSchema.validate(req.body);
  if (error) {
    console.log('Checkup validation error:', error.details);
  }
  handleValidationError(error, next);
};

module.exports.validateObservationItem = (req, res, next) => {
  const { error } = observationItemSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateSendOtp = (req, res, next) => {
  const { error } = sendOtpSchema.validate(req.body);
  if (error) {
    console.log('Invalid OTP request');
  } else {
    console.log('Valid OTP request');
  }
  handleValidationError(error, next);
};

module.exports.validateVerifyOtp = (req, res, next) => {
  const { error } = verifyOtpSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateUser = (req, res, next) => {
  const { error } = userSchema.validate(req.body);
  handleValidationError(error, next);
};

module.exports.validateFeedback = (req, res, next) => {
  const { error } = feedbackSchema.validate(req.body);
  handleValidationError(error, next);
};

// Helper function to handle validation errors
function handleValidationError(error, next) {
  if (error) {
    const msg = error.details.map((e) => e.message).join(",");
    throw new ExpressError(msg, 400);
  } else {
    next();
  }
}