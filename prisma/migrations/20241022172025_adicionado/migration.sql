/*
  Warnings:

  - Added the required column `id_fazenda` to the `Lote` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Lote` ADD COLUMN `id_fazenda` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `Lote` ADD CONSTRAINT `Lote_id_fazenda_fkey` FOREIGN KEY (`id_fazenda`) REFERENCES `Fazenda`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
