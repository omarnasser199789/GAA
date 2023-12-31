// AppInterface.ts
import { PrismaClient } from '@prisma/client';

export interface AppInterface {
  prismaClient: PrismaClient;
}
