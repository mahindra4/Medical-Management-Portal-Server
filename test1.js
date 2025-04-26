require("dotenv").config();
const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function addDiagnosisSymptom() {
  try {
    const result = await prisma.diagnosisSymptoms.create({
      data: {
        diagnosis: "Diabetes",
        symptom: "Frequent urination",
      },
    });

    console.log("Inserted:", result);
  } catch (error) {
    console.error("Error inserting diagnosis symptom:", error);
  } finally {
    await prisma.$disconnect();
  }
}

addDiagnosisSymptom();
