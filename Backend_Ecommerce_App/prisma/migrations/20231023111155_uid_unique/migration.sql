/*
  Warnings:

  - A unique constraint covering the columns `[uid]` on the table `LoginWithQrKey` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `LoginWithQrKey_uid_key` ON `LoginWithQrKey`(`uid`);
