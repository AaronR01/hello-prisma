-- CreateTable
CREATE TABLE "administrador_sistema" (
    "id_administrador" INTEGER NOT NULL,
    "senha" VARCHAR(255),
    "nome" VARCHAR(255),
    "email" VARCHAR(255),
    "telefone" VARCHAR(255),

    CONSTRAINT "administrador_sistema_pkey" PRIMARY KEY ("id_administrador")
);

-- CreateTable
CREATE TABLE "alimento" (
    "id_alimento" INTEGER NOT NULL,
    "descricao" VARCHAR(255),

    CONSTRAINT "alimento_pkey" PRIMARY KEY ("id_alimento")
);

-- CreateTable
CREATE TABLE "analise" (
    "id_analise" INTEGER NOT NULL,
    "imagem" VARCHAR(255),
    "resultado" VARCHAR(255),
    "disposicao" VARCHAR(255),
    "manejo" VARCHAR(255),
    "comportamento" VARCHAR(255),
    "clima" VARCHAR(255),
    "data" VARCHAR(255),
    "id_lote" INTEGER,

    CONSTRAINT "analise_pkey" PRIMARY KEY ("id_analise")
);

-- CreateTable
CREATE TABLE "dieta" (
    "id_dieta" INTEGER NOT NULL,
    "data" DATE,

    CONSTRAINT "dieta_pkey" PRIMARY KEY ("id_dieta")
);

-- CreateTable
CREATE TABLE "dieta_lote" (
    "id_lote" INTEGER,
    "id_dieta" INTEGER,
    "id_alimento" INTEGER,
    "quantidade" DOUBLE PRECISION
);

-- CreateTable
CREATE TABLE "fazenda" (
    "id_fazenda" INTEGER NOT NULL,
    "nome" VARCHAR(255),
    "cidade" VARCHAR(255),
    "estado" VARCHAR(255),
    "proprietario" VARCHAR(255),
    "id_adm" INTEGER,

    CONSTRAINT "fazenda_pkey" PRIMARY KEY ("id_fazenda")
);

-- CreateTable
CREATE TABLE "lote" (
    "id_lote" INTEGER NOT NULL,
    "nome" VARCHAR(255),
    "qtde_animais" INTEGER,
    "espacamento" DOUBLE PRECISION,
    "idfazenda" INTEGER,

    CONSTRAINT "lote_pkey" PRIMARY KEY ("id_lote")
);

-- CreateTable
CREATE TABLE "usuario" (
    "id_usuario" INTEGER NOT NULL,
    "nome" VARCHAR(255),
    "email" VARCHAR(255),
    "senha" VARCHAR(255),
    "telefone" VARCHAR(255),
    "id_faz" INTEGER,
    "e_administrador" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateIndex
CREATE UNIQUE INDEX "dieta_lote_id_lote_key" ON "dieta_lote"("id_lote");
