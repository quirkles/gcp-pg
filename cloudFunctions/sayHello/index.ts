import { Request, Response } from 'express';

import { join } from "ramda"

const message = join(" ", ["hello", "world"])

export const main = (_: Request, res: Response ) => res.send(message);
