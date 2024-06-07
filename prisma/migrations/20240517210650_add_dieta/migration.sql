/*
  Warnings:

  - Made the column `id_lote` on table `dieta_lote` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "dieta_lote_id_lote_key";

-- AlterTable
ALTER TABLE "dieta_lote" ALTER COLUMN "id_lote" SET NOT NULL,
ADD CONSTRAINT "dieta_lote_pkey" PRIMARY KEY ("id_lote");
