-- CreateTable
CREATE TABLE "procedures" (
    "id" TEXT NOT NULL,
    "patientEmail" TEXT NOT NULL,
    "patientName" TEXT NOT NULL,
    "inTime" TIMESTAMP(3) NOT NULL,
    "procedureRecord" TEXT NOT NULL,
    "patientConditionBefore" TEXT NOT NULL,
    "referredHospital" TEXT NOT NULL,
    "outTime" TIMESTAMP(3)
);

-- CreateIndex
CREATE UNIQUE INDEX "procedures_id_key" ON "procedures"("id");
