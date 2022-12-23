import joi from "joi";

export const shortLinkSchema = joi.object({
  url: joi.string().uri().required(),
});
