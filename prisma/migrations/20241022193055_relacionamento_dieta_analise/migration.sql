/*
  Warnings:

  - You are about to drop the column `data` on the `Dieta` table. All the data in the column will be lost.
  - Added the required column `id_dieta` to the `Analise` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Analise` ADD COLUMN `id_dieta` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `Dieta` DROP COLUMN `data`;

-- AddForeignKey
ALTER TABLE `Analise` ADD CONSTRAINT `Analise_id_dieta_fkey` FOREIGN KEY (`id_dieta`) REFERENCES `Dieta`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
