require("../utils/utils");
const { PrismaClient } = require("@prisma/client");

class BaseController {
  public io  = null;
  public prismaClient = new PrismaClient({
    log: [
      {
        emit: "event",
        level: "query",
      },
    ],
  });
  constructor() {
    this.prismaClient.$on("query", async (e) => {
      console.log(`${e.query} ${e.params}`);
    });
  }

  public calculatePages: Function = (pageSize, count) => {
    if (pageSize == 0) return 0;
    return Math.ceil(count / pageSize);
  };

  public async saveAttachments(
    objectTable: string,
    objectId: number,
    paths,
    user
  ) {
    await this.prismaClient.Attachment.createMany({
      data: paths.map((p) => {
        return {
          objectTable,
          objectId,
          path: p.path,
          createdBy: +user.id,
        };
      }),
    });
  }

  public async loadAttachments(objectTable: string, objectId: number) {
    return await this.prismaClient.Attachment.findMany({
      select: {
        id: true,
        path: true,
      },
      where: {
        objectId,
        objectTable,
        deleted: false,
      },
    });
  }
}

export default BaseController;
