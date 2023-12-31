// seedRoles.ts
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  // Create roles
  await prisma.role.createMany({
    data: [
      { name: 'admin' },
      { name: 'user' },
      // Add more roles if needed
    ],
  });

  // Create user with admin role
  await prisma.user.create({
    data: {
      uid: 'Ej0ZK6tc03ena3MzC53JUOzaMOH4',
      username: 'Omar Nasser',
      email: 'omarrnaser1997@gmail.com',
      phoneNumber: '+9647518107823',
      fcmToken: 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYyZTgyNzMyYjk3MWExMzVjZjE0MTZlOGI0NmRhZTA0ZDgwODk0ZTciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZWNhcHAtNmY4NzgiLCJhdWQiOiJlY2FwcC02Zjg3OCIsImF1dGhfdGltZSI6MTY5NzU2MDQ3MCwidXNlcl9pZCI6IkVqMFpLNnRjMDNlbmEzTXpDNTNKVU96YU1PSDIiLCJzdWIiOiJFajBaSzZ0YzAzZW5hM016QzUzSlVPemFNT0gyIiwiaWF0IjoxNjk3NTYwNDcwLCJleHAiOjE2OTc1NjQwNzAsInBob25lX251bWJlciI6Iis5NjQ3LTg4MDMzNDE1NzUwMTIiwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJwaG9uZSI6WyIrOTY0NzUwODEwNzgyMyJdfSwic2lnbl9pbl9wcm92aWRlciI6InBob25lIn19.fjfazeJKIC6ffkniM52vraAhjFDWkAdAmPq1RTwIdtDDXBXjxp5B5P1M5hf9x8qr_JJAwxYneCXB5KYHq7QOVfBrn2EQQcGDHFWH8L6eRt0FuheM5R-hL3frtBQGXHrtGNhjh-X517tzfMxfzGFvnQtxoYaxdj696HqQSoOzagfaTDYfmSR6h8N9hCVxdwoUHxjBokGpbGaSWA2EhWI6bVkuxgCAb7Ll8AT7gE3aLn_NUYnljMcrLhPAhIb0ursZBmq1GuxzCE542uosZU7rOs_s4Gg5zF6R2dIkZhsmhkckZoLmkx2ae0rEtNmJc0G_cDD1RRLA',
      roles: {
        connect: { name: 'admin' }, // Connect this user to the 'admin' role
      },
    },
  });
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
