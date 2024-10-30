/*
  Warnings:

  - You are about to drop the `dieta_lote` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `eh_atual` to the `Dieta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_lote` to the `Dieta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_adm` to the `Fazenda` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_fazenda` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `dieta_lote` DROP FOREIGN KEY `Dieta_Lote_id_alimento_fkey`;

-- DropForeignKey
ALTER TABLE `dieta_lote` DROP FOREIGN KEY `Dieta_Lote_id_dieta_fkey`;

-- DropForeignKey
ALTER TABLE `dieta_lote` DROP FOREIGN KEY `Dieta_Lote_id_lote_fkey`;

-- DropForeignKey
ALTER TABLE `fazenda` DROP FOREIGN KEY `Fazenda_id_fkey`;

-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `User_id_fkey`;

-- AlterTable
ALTER TABLE `dieta` ADD COLUMN `eh_atual` BOOLEAN NOT NULL,
    ADD COLUMN `id_lote` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `fazenda` ADD COLUMN `id_adm` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `id_fazenda` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `dieta_lote`;

-- CreateTable
CREATE TABLE `Receita` (
    `id` VARCHAR(191) NOT NULL,
    `id_dieta` VARCHAR(191) NOT NULL,
    `id_alimento` VARCHAR(191) NOT NULL,
    `quantidade` DOUBLE NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_id_fazenda_fkey` FOREIGN KEY (`id_fazenda`) REFERENCES `Fazenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Fazenda` ADD CONSTRAINT `Fazenda_id_adm_fkey` FOREIGN KEY (`id_adm`) REFERENCES `administrador_sistema`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Receita` ADD CONSTRAINT `Receita_id_alimento_fkey` FOREIGN KEY (`id_alimento`) REFERENCES `Alimento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Receita` ADD CONSTRAINT `Receita_id_dieta_fkey` FOREIGN KEY (`id_dieta`) REFERENCES `Dieta`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta` ADD CONSTRAINT `Dieta_id_lote_fkey` FOREIGN KEY (`id_lote`) REFERENCES `Lote`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
