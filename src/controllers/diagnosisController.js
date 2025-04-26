const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const getDiagnosisSymptomsList = async (req, res, next) => {
    try{
        console.log('-------siudhf asduhfu asbf 8hsa hf');
        const diagnosisSymptomsList = await prisma.diagnosisSymptoms.findMany();
        console.log("diagnos symptoms list: ",diagnosisSymptomsList);
        const formattedData = diagnosisSymptomsList.reduce((acc,{diagnosis,symptom}) => {
            if(!acc[diagnosis]){
                acc[diagnosis] = []
            }
            acc[diagnosis].push(symptom);
            return acc;
        },{})

        return res.status(200).json({
            ok: true,
            data: formattedData,
            message: "Diagnosis-Symptoms List fetched successfully"
        })
        
    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Fetching Diagnosis-Symptoms List Failed, Try again later"
        })
    }
}

const getDiagnosisListById = async(req, res, next) => {
    try{
        const {id} = req.params;
        const diagnosisSymptomsList = await prisma.diagnosisSymptoms.findMany({
            where: {
                id: id
            }
        })
        // console.log(diagnosisSymptomsList)
        return res.status(200).json({
            ok: true,
            data: diagnosisSymptomsList,
            message: "Diagnosis-Symptoms List fetched successfully"
        })

    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Fetching Diagnosis-Symptoms List Failed, Try again later"
        })
    }     
}

const getDiagnosisSymptomListNonFormatted = async (req, res, next) => {
    try{
        // console.log('............a;sduhfsauhfashdfliuhsa................uaydgfysadg fuh')
        const diagnosisSymptomsList = await prisma.diagnosisSymptoms.findMany({
            orderBy: {id: 'asc'},
        });    
        console.log(diagnosisSymptomsList.length)
        return res.status(200).json({
            ok: true,
            data: diagnosisSymptomsList,
            message: "Diagnosis-Symptoms List fetched successfully fetched"
        })

    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Fetching Diagnosis-Symptoms List Failed, Try again later"
        })
    }     
}

const getDiagnosisList = async (req, res, next) => {
    try{
        const diagnosisList = await prisma.diagnosisSymptoms.findMany({
            select: {
                diagnosis: true
            }
        })
        // console.log(diagnosisList)
        const formattedData = [...new Set(diagnosisList.map(item => item.diagnosis))];
        return res.status(200).json({
            ok: true,
            data: formattedData,
            message: "Diagnosis List fetched successfully"
        })

    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Fetching Diagnosis List Failed, Try again later"
        })
    }
}

const addDiagnosis = async (req, res, next) => {
    try{
        const {diagnosis, symptom} = req.body;
        const diagnosisSymptomsList = await prisma.diagnosisSymptoms.findMany({
            where: {
                diagnosis: diagnosis,
                symptom: symptom
            }
        })
        if(diagnosisSymptomsList.length > 0){
            return res.status(400).json({
                ok: false,
                data: [],
                message: "Diagnosis - symptoms already exists"
            })
        }
        const newDiagnosis = await prisma.diagnosisSymptoms.create({
            data: {
                diagnosis: diagnosis,
                symptom: symptom
            }
        })
        return res.status(200).json({
            ok: true,
            data: newDiagnosis,
            message: "Diagnosis added successfully"
        })

    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Adding Diagnosis Failed, Try again later"
        })
    }
}

const deleteDiagnosis = async (req, res, next) => {
    try{
        const {id} = req.params;
        const deletedDiagnosis = await prisma.diagnosisSymptoms.delete({
            where: {
                id: id
            }
        })
        return res.status(200).json({
            ok: true,
            data: deletedDiagnosis,
            message: "Diagnosis deleted successfully"
        })

    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Deleting Diagnosis Failed, Try again later"
        })
    }
}
       
const updateDiagnosis = async (req, res, next) => {
    try{
        const {id} = req.params;
        const {diagnosis, symptom} = req.body;
        console.log('updateDiagnosis: ', id, diagnosis, symptom)
        const updatedDiagnosis = await prisma.diagnosisSymptoms.update({
            where: {
                id: id
            },
            data: {
                diagnosis: diagnosis,
                symptom: symptom
            }
        })
        return res.status(200).json({
            ok: true,
            data: updatedDiagnosis,
            message: "Diagnosis updated successfully"
        })

    } catch(err){
        console.log(err);
        return res.status(500).json({
            ok: false,
            data: [],
            message: "Updating Diagnosis Failed, Try again later"
        })
    }
}

module.exports = {getDiagnosisSymptomsList, 
                  getDiagnosisSymptomListNonFormatted, 
                  getDiagnosisList, 
                  addDiagnosis,
                  deleteDiagnosis,
                  getDiagnosisListById,
                  updateDiagnosis,
                };