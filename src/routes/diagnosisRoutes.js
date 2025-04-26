const express = require('express');
const router = express.Router();
const catchAsync = require('../utils/catchAsync');

const authMiddleware = require("../middlewares/authMiddleware");
const profileMiddleware = require("../middlewares/profileMiddleware");

const roleMap = require("../utils/roleMap");

const {getDiagnosisSymptomsList, getDiagnosisList, addDiagnosis, getDiagnosisSymptomListNonFormatted, deleteDiagnosis, getDiagnosisListById, updateDiagnosis} = require('../controllers/diagnosisController')

router.use(authMiddleware([], false), profileMiddleware(true));

router.get('/', authMiddleware(roleMap("GET_DIAGNOSIS_LIST")), catchAsync(getDiagnosisList));
router.get('/list', authMiddleware(roleMap("GET_DIAGNOSIS_LIST")), catchAsync(getDiagnosisSymptomListNonFormatted));
router.get('/symptoms', authMiddleware(roleMap("GET_DIAGNOSIS_SYMPTOMS_LIST")), catchAsync(getDiagnosisSymptomsList));
router.get('/:id', authMiddleware(roleMap("GET_DIAGNOSIS_LIST")), catchAsync(getDiagnosisListById));
router.post('/add', authMiddleware(roleMap("ADD_DIAGNOSIS")), catchAsync(addDiagnosis));
router.delete('/:id', authMiddleware(roleMap("DELETE_DIAGNOSIS_SYMPTOM")), catchAsync(deleteDiagnosis));
router.put('/:id', authMiddleware(roleMap("UPDATE_DIAGNOSIS_SYMPTOM")), catchAsync(updateDiagnosis));
module.exports = router;