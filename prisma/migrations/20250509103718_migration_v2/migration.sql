-- CreateTable
CREATE TABLE "VisitingSpecialist" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "specialization" TEXT NOT NULL,
    "availableTime" TEXT NOT NULL,
    "availableDays" TEXT[],
    "contactNumber" TEXT NOT NULL,
    "email" TEXT,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "VisitingSpecialist_pkey" PRIMARY KEY ("id")
);
