const Joi = require("joi");

// Medicine Schema
const medicineSchema = Joi.object({
  brandName: Joi.string().required(),
  saltName: Joi.string()
    .pattern(/^[a-zA-Z]+$/)
    .required(),
  categoryId: Joi.string().required(),
});

// Supplier Schema
const supplierSchema = Joi.object({
  name: Joi.string().required().min(3).max(30),
  address1: Joi.string().required(),
  address2: Joi.string().allow(null).allow('').optional(),
  city: Joi.string().allow(null).allow('').optional(),
  state: Joi.string().required(),
  pinCode: Joi.number().integer().min(10 ** 5).max(10 ** 6 - 1).allow(null).allow('').optional(),
  mobileNumber: Joi.string().length(10).pattern(/^[0-9]+$/).required(),
  email: Joi.string().email().allow(null).allow('').optional(),
});

// Staff Schema
const staffSchema = Joi.object({
  name: Joi.string().required().min(3).max(30),
  email: Joi.string().email().required(),
  mobileNumber: Joi.string().length(10).pattern(/^[0-9]+$/).allow(null).allow('').optional(),
  role: Joi.string().valid("DOCTOR", "PARAMEDICAL").required(),
  department: Joi.string()
    .valid("AYURVEDIC", "GYNECOLOGY", "HOMEOPATHY", "OTHERS")
    .allow(null).allow('').optional(),
  speciality: Joi.string().allow(null).allow('').optional(),  
  gender: Joi.string().valid("MALE", "FEMALE").required(),
});

// Schedule Schema
const scheduleSchema = Joi.object({
  email: Joi.string().email().required(),
  staffId: Joi.string().required(),
  shift: Joi.string().valid("MORNING", "AFTERNOON", "NIGHT").required(),
  day: Joi.string()
    .valid(
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY",
      "SUNDAY"
    )
    .required(),
});

// Stock Schema
const stockSchema = Joi.object({
  medicineId: Joi.string().required(),
  stock: Joi.number().integer().required(),
  inQuantity: Joi.number().integer().required(),
  outQuantity: Joi.number().integer().required(),
});

// Purchase Schema
const purchaseSchema = Joi.object({
  medicineId: Joi.string().required(),
  mfgDate: Joi.date().allow(null).allow('').optional(),
  expiryDate: Joi.date().required(),
  batchNo: Joi.number().integer().min(1).required(),
  quantity: Joi.number().integer().min(1).required(),
});

// PurchaseList Schema
const purchaseListSchema = Joi.object({
  supplierId: Joi.string().required(),
  purchaseDate: Joi.date().required(),
  invoiceNo: Joi.number().integer().min(1).required(),
  purchaseDetails: Joi.string().allow(null).allow('').optional(),
  purchaseItems: Joi.array().items(purchaseSchema).required(),
});

// Category Schema
const categorySchema = Joi.object({
  categoryName: Joi.string().required(),
  strengthType: Joi.string().required(),
});

// Observation Item Schema
const observationItemSchema = Joi.object({
  medicineId: Joi.string().optional(),
  dosage: Joi.string().allow('').optional(),
  frequency: Joi.string().allow('').optional(),
  dailyQuantity: Joi.number().integer().optional(),
  days: Joi.number().integer().optional(),
  availableQty: Joi.number().integer().optional()
});

// Patient Schema
const patientSchema = Joi.object({
  name: Joi.string().required().min(3).max(30),
  department: Joi.string()
    .valid(
      "COMPUTER_SCIENCE",
      "ELECTRICAL",
      "MECHANICAL",
      "MATHEMATICS_COMPUTING",
      "CHEMICAL",
      "CIVIL",
      "METALLURGY",
      "ENGINEERING_PHYSICS",
      "PHYSICS",
      "CHEMISTRY",
      "BIOLOGY",
      "MATHEMATICS",
      "HUMANITIES"
    )
    .allow(null).allow('').optional(),
  age: Joi.number().integer().min(1).max(100).required(),
  email: Joi.string().email().required(),
  allergy: Joi.string().allow(null).allow('').optional(),
  bloodGroup: Joi.string().required(),
  program: Joi.string()
    .valid("BTECH", "MTECH", "DUAL_DEGREE", "PHD")
    .allow(null).allow('').optional(),
  fatherOrSpouseName: Joi.string().min(3).max(30).allow(null).allow('').optional(),
  category: Joi.string()
    .valid("STUDENT", "FACULTY", "STAFF", "VISITOR")
    .required(),
  gender: Joi.string().valid("MALE", "FEMALE").required(),
});

// Checkup Medicines Schema
const checkupMedicinesSchema = Joi.object({
  medicineId: Joi.string().required(),
  dosage: Joi.string().allow(null).allow('').optional(),
  quantity: Joi.number().integer().min(1).required(),
});

// Checkup Schema (merged version)
const checkupSchema = Joi.object({
  id: Joi.string().optional(), 
  patientId: Joi.string().required(),
  staffEmail: Joi.string().email().required(),
  temperature: Joi.number().allow(null).allow('').optional(),
  pulseRate: Joi.number().integer().allow(null).allow('').optional(),
  spO2: Joi.number().min(0).max(100).allow(null).allow('').optional(),
  bloodPressure: Joi.string().allow(null).allow('').optional(),
  date: Joi.date().required(),
  doctorId: Joi.string().allow(null).allow('').optional(),
  symptoms: Joi.string().allow(null).allow('').optional(),
  diagnosis: Joi.string().required(),
  checkupMedicines: Joi.array().items(checkupMedicinesSchema).required(),
  referredDoctor: Joi.string().allow(null).allow('').optional(),
  referredHospital: Joi.string().allow(null).allow('').optional(),
  isUnderObservation: Joi.boolean().default(false), // From your version
  observationDetails: Joi.when('isUnderObservation', { // From your version
    is: true,
    then: Joi.array().items(
      Joi.object({
        medicineId: Joi.string().required(),
        dosage: Joi.string().allow('', null).optional(),
        frequency: Joi.string().allow('', null).optional(),
        dailyQuantity: Joi.number().integer().min(1).required(),
        days: Joi.number().integer().min(1).required(),
        availableQty: Joi.number().integer().optional()
      })
    ).min(1).required().messages({
      'array.base': 'Observation details must be an array of objects when patient is under observation',
      'array.min': 'At least one observation medicine is required when patient is under observation',
      'any.required': 'Observation details are required when patient is under observation'
    }),
    otherwise: Joi.array().optional().allow(null)
  })
});

// OTP Schemas
const sendOtpSchema = Joi.object({
  email: Joi.string().email().required(),
  action: Joi.string().valid("LOGIN", "SIGNUP").required(),
});

const verifyOtpSchema = Joi.object({
  email: Joi.string().email().required(),
  otp: Joi.string().required(),
});

// User Schema
const userSchema = Joi.object({
  email: Joi.string().email().required(),
  name: Joi.string().required().min(3).max(30),
  role: Joi.string()
    .required()
    .valid("DOCTOR", "PATIENT", "ADMIN", "PARAMEDICAL"),
});

// Feedback Schema
const feedbackSchema = Joi.object({
  subject: Joi.string().required(),
  message: Joi.string().required().min(10).max(300)
});

module.exports = {
  medicineSchema,
  supplierSchema,
  staffSchema,
  scheduleSchema,
  stockSchema,
  purchaseListSchema,
  categorySchema,
  purchaseSchema,
  patientSchema,
  checkupSchema,
  sendOtpSchema,
  verifyOtpSchema,
  userSchema,
  feedbackSchema,
  observationItemSchema
};