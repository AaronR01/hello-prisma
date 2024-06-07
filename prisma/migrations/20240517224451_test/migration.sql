-- DropForeignKey
ALTER TABLE "fazenda" DROP CONSTRAINT "fazenda_id_adm_fkey";

-- AlterTable
CREATE SEQUENCE fazenda_id_fazenda_seq;
ALTER TABLE "fazenda" ALTER COLUMN "id_fazenda" SET DEFAULT nextval('fazenda_id_fazenda_seq');
ALTER SEQUENCE fazenda_id_fazenda_seq OWNED BY "fazenda"."id_fazenda";
