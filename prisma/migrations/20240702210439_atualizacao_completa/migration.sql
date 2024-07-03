/*
  Warnings:

  - Added the required column `id_lote` to the `Analise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `resultado` to the `Analise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantidade_animais` to the `Lote` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Analise` ADD COLUMN `Clima` VARCHAR(191) NULL,
    ADD COLUMN `Data` DATETIME(3) NULL,
    ADD COLUMN `comportamento` VARCHAR(191) NULL,
    ADD COLUMN `disposicao` VARCHAR(191) NULL,
    ADD COLUMN `id_lote` INTEGER NOT NULL,
    ADD COLUMN `imagem` VARCHAR(191) NULL,
    ADD COLUMN `manejo` VARCHAR(191) NULL,
    ADD COLUMN `resultado` DOUBLE NOT NULL;

-- AlterTable
ALTER TABLE `Lote` ADD COLUMN `quantidade_animais` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `Dieta_Lote` (
    `id_lote` INTEGER NOT NULL,
    `id_dieta` INTEGER NOT NULL,
    `id_alimento` INTEGER NOT NULL,
    `quantidade` DOUBLE NOT NULL,

    PRIMARY KEY (`id_lote`, `id_dieta`, `id_alimento`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Dieta` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Data` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Alimento` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `Descricao` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_id_fkey` FOREIGN KEY (`id`) REFERENCES `Fazenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta_Lote` ADD CONSTRAINT `Dieta_Lote_id_lote_fkey` FOREIGN KEY (`id_lote`) REFERENCES `Lote`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta_Lote` ADD CONSTRAINT `Dieta_Lote_id_dieta_fkey` FOREIGN KEY (`id_dieta`) REFERENCES `Dieta`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta_Lote` ADD CONSTRAINT `Dieta_Lote_id_alimento_fkey` FOREIGN KEY (`id_alimento`) REFERENCES `Alimento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Analise` ADD CONSTRAINT `Analise_id_lote_fkey` FOREIGN KEY (`id_lote`) REFERENCES `Lote`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
