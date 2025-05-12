const express = require('express');
const router = express.Router();
const catchAsync = require('../utils/catchAsync');
const {
  getAllObservations,
  getObservation,
  updateObservation,
  deleteObservation,
  getPatientObservationHistory
} = require('../controllers/observationController');

const authMiddleware = require("../middlewares/authMiddleware");
const profileMiddleware = require("../middlewares/profileMiddleware");
const roleMap = require("../utils/roleMap");

// Observation routes
router.route('/')
  .get(
    authMiddleware(roleMap("GET_OBSERVATION")),
    profileMiddleware(true),
    catchAsync(getAllObservations)
  );

router.get('/history/:email',
    authMiddleware(roleMap("GET_OBSERVATION_HISTORY")), 
    profileMiddleware(true),
    catchAsync(getPatientObservationHistory)
  );

router.route('/:id')
  .get(
    authMiddleware(roleMap("GET_OBSERVATION")),
    profileMiddleware(true),
    catchAsync(getObservation)
  )
  .put(
    authMiddleware(roleMap("UPDATE_OBSERVATION")),
    profileMiddleware(true),
    catchAsync(updateObservation)
  )
  .delete(
    authMiddleware(roleMap("DELETE_OBSERVATION")),
    profileMiddleware(true),
    catchAsync(deleteObservation)
  );


module.exports = router;