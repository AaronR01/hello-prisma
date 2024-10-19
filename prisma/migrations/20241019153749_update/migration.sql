/*
  Warnings:

  - The primary key for the `Alimento` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Descricao` on the `Alimento` table. All the data in the column will be lost.
  - The primary key for the `Analise` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Clima` on the `Analise` table. All the data in the column will be lost.
  - You are about to drop the column `Data` on the `Analise` table. All the data in the column will be lost.
  - The primary key for the `Dieta` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Data` on the `Dieta` table. All the data in the column will be lost.
  - The primary key for the `Dieta_Lote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Fazenda` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `Lote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `User` table. All the data in the column will be lost.
  - The primary key for the `administrador_sistema` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Telefone` on the `administrador_sistema` table. All the data in the column will be lost.
  - Added the required column `descricao` to the `Alimento` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `Alimento` table without a default value. This is not possible if the table is not empty.
  - Added the required column `clima` to the `Analise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `data` to the `Analise` table without a default value. This is not possible if the table is not empty.
  - Made the column `comportamento` on table `Analise` required. This step will fail if there are existing NULL values in that column.
  - Made the column `disposicao` on table `Analise` required. This step will fail if there are existing NULL values in that column.
  - Made the column `manejo` on table `Analise` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `data` to the `Dieta` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tamanho` to the `Lote` table without a default value. This is not possible if the table is not empty.
  - Added the required column `eh_administrador` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nome` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `senha` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `telefone` to the `administrador_sistema` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Analise` DROP FOREIGN KEY `Analise_id_lote_fkey`;

-- DropForeignKey
ALTER TABLE `Dieta_Lote` DROP FOREIGN KEY `Dieta_Lote_id_alimento_fkey`;

-- DropForeignKey
ALTER TABLE `Dieta_Lote` DROP FOREIGN KEY `Dieta_Lote_id_dieta_fkey`;

-- DropForeignKey
ALTER TABLE `Dieta_Lote` DROP FOREIGN KEY `Dieta_Lote_id_lote_fkey`;

-- DropForeignKey
ALTER TABLE `Fazenda` DROP FOREIGN KEY `Fazenda_id_fkey`;

-- DropForeignKey
ALTER TABLE `User` DROP FOREIGN KEY `User_id_fkey`;

-- AlterTable
ALTER TABLE `Alimento` DROP PRIMARY KEY,
    DROP COLUMN `Descricao`,
    ADD COLUMN `descricao` VARCHAR(191) NOT NULL,
    ADD COLUMN `nome` VARCHAR(191) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Analise` DROP PRIMARY KEY,
    DROP COLUMN `Clima`,
    DROP COLUMN `Data`,
    ADD COLUMN `clima` VARCHAR(191) NOT NULL,
    ADD COLUMN `data` DATETIME(3) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    MODIFY `comportamento` VARCHAR(191) NOT NULL,
    MODIFY `disposicao` VARCHAR(191) NOT NULL,
    MODIFY `id_lote` VARCHAR(191) NOT NULL,
    MODIFY `manejo` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Dieta` DROP PRIMARY KEY,
    DROP COLUMN `Data`,
    ADD COLUMN `data` DATETIME(3) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Dieta_Lote` DROP PRIMARY KEY,
    MODIFY `id_lote` VARCHAR(191) NOT NULL,
    MODIFY `id_dieta` VARCHAR(191) NOT NULL,
    MODIFY `id_alimento` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id_lote`, `id_dieta`, `id_alimento`);

-- AlterTable
ALTER TABLE `Fazenda` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `Lote` DROP PRIMARY KEY,
    ADD COLUMN `tamanho` INTEGER NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `User` DROP PRIMARY KEY,
    DROP COLUMN `name`,
    DROP COLUMN `password`,
    ADD COLUMN `eh_administrador` BOOLEAN NOT NULL,
    ADD COLUMN `nome` VARCHAR(191) NOT NULL,
    ADD COLUMN `senha` VARCHAR(191) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `administrador_sistema` DROP PRIMARY KEY,
    DROP COLUMN `Telefone`,
    ADD COLUMN `telefone` VARCHAR(191) NOT NULL,
    MODIFY `id` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_id_fkey` FOREIGN KEY (`id`) REFERENCES `Fazenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Fazenda` ADD CONSTRAINT `Fazenda_id_fkey` FOREIGN KEY (`id`) REFERENCES `administrador_sistema`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta_Lote` ADD CONSTRAINT `Dieta_Lote_id_alimento_fkey` FOREIGN KEY (`id_alimento`) REFERENCES `Alimento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta_Lote` ADD CONSTRAINT `Dieta_Lote_id_dieta_fkey` FOREIGN KEY (`id_dieta`) REFERENCES `Dieta`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Dieta_Lote` ADD CONSTRAINT `Dieta_Lote_id_lote_fkey` FOREIGN KEY (`id_lote`) REFERENCES `Lote`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Analise` ADD CONSTRAINT `Analise_id_lote_fkey` FOREIGN KEY (`id_lote`) REFERENCES `Lote`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
