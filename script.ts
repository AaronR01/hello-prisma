import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()

async function main()
{
    const user = await prisma.user.create
    ({
        data: {
            name: "nome",
            password: "senha",
            telefone: "123-4123-51223-333",
        }
    })
    console.log(user)
}

main()
.catch(e => {
    console.log(e.message)
})
.finally(async () => {
    await prisma.$disconnect()
})