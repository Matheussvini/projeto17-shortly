import joi from 'joi';

export const signUpSchema = joi.object({
    name: joi.string().min(2).required(),
    email: joi.string().email().required(),
    password: joi.string().min(5).required(),
    confirmPassword: joi.string().min(5).required()
})

export const signInSchema = joi.object({
    email: joi.string().email().required(),
    password: joi.string().min(5).required()
});