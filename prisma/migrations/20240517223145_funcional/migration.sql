/*
  Warnings:

  - The primary key for the `administrador_sistema` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id_administrador` on the `administrador_sistema` table. All the data in the column will be lost.
  - The primary key for the `dieta_lote` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idfazenda` on the `lote` table. All the data in the column will be lost.
  - You are about to drop the column `id_faz` on the `usuario` table. All the data in the column will be lost.
  - Added the required column `id_adm` to the `administrador_sistema` table without a default value. This is not possible if the table is not empty.
  - Made the column `id_dieta` on table `dieta_lote` required. This step will fail if there are existing NULL values in that column.
  - Made the column `id_alimento` on table `dieta_lote` required. This step will fail if there are existing NULL values in that column.
  - Made the column `quantidade` on table `dieta_lote` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "administrador_sistema" DROP CONSTRAINT "administrador_sistema_pkey",
DROP COLUMN "id_administrador",
ADD COLUMN     "id_adm" INTEGER NOT NULL,
ADD CONSTRAINT "administrador_sistema_pkey" PRIMARY KEY ("id_adm");

-- AlterTable
ALTER TABLE "dieta_lote" DROP CONSTRAINT "dieta_lote_pkey",
ALTER COLUMN "id_dieta" SET NOT NULL,
ALTER COLUMN "id_alimento" SET NOT NULL,
ALTER COLUMN "quantidade" SET NOT NULL,
ADD CONSTRAINT "dieta_lote_pkey" PRIMARY KEY ("id_lote", "id_dieta", "id_alimento");

-- AlterTable
ALTER TABLE "lote" DROP COLUMN "idfazenda",
ADD COLUMN     "id_fazenda" INTEGER;

-- AlterTable
ALTER TABLE "usuario" DROP COLUMN "id_faz",
ADD COLUMN     "id_fazenda" INTEGER;

-- AddForeignKey
ALTER TABLE "analise" ADD CONSTRAINT "analise_id_lote_fkey" FOREIGN KEY ("id_lote") REFERENCES "lote"("id_lote") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dieta_lote" ADD CONSTRAINT "dieta_lote_id_alimento_fkey" FOREIGN KEY ("id_alimento") REFERENCES "alimento"("id_alimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dieta_lote" ADD CONSTRAINT "dieta_lote_id_dieta_fkey" FOREIGN KEY ("id_dieta") REFERENCES "dieta"("id_dieta") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "dieta_lote" ADD CONSTRAINT "dieta_lote_id_lote_fkey" FOREIGN KEY ("id_lote") REFERENCES "lote"("id_lote") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "fazenda" ADD CONSTRAINT "fazenda_id_adm_fkey" FOREIGN KEY ("id_adm") REFERENCES "administrador_sistema"("id_adm") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "lote" ADD CONSTRAINT "lote_id_fazenda_fkey" FOREIGN KEY ("id_fazenda") REFERENCES "fazenda"("id_fazenda") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "usuario" ADD CONSTRAINT "usuario_id_fazenda_fkey" FOREIGN KEY ("id_fazenda") REFERENCES "fazenda"("id_fazenda") ON DELETE NO ACTION ON UPDATE NO ACTION;
