/*
  Warnings:

  - The primary key for the `alimento` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `alimento` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.
  - You are about to alter the column `id_alimento` on the `receita` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Int`.

*/
-- DropForeignKey
ALTER TABLE `receita` DROP FOREIGN KEY `Receita_id_alimento_fkey`;

-- AlterTable
ALTER TABLE `alimento` DROP PRIMARY KEY,
    MODIFY `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `receita` MODIFY `id_alimento` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `Receita` ADD CONSTRAINT `Receita_id_alimento_fkey` FOREIGN KEY (`id_alimento`) REFERENCES `Alimento`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
