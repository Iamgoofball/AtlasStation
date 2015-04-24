/mob/living/carbon/human/movement_delay()
	if(dna)
		. += dna.species.movement_delay(src)

	. += ..()
	. += config.human_delay

/mob/living/carbon/human/Process_Spacemove(var/movement_dir = 0)

	if(..())
		return 1

	//Do we have a working jetpack
	if(istype(back, /obj/item/weapon/tank/jetpack) && isturf(loc)) //Second check is so you can't use a jetpack in a mech
		var/obj/item/weapon/tank/jetpack/J = back
		if((movement_dir || J.stabilization_on) && J.allow_thrust(0.01, src))
			return 1
	return 0


/mob/living/carbon/human/slip(var/s_amount, var/w_amount, var/obj/O, var/lube)
	if(isobj(shoes) && (shoes.flags&NOSLIP) && !(lube&GALOSHES_DONT_HELP))
		return 0
	.=..()

/mob/living/carbon/human/mob_has_gravity()
	. = ..()
	if(!.)
		if(mob_negates_gravity())
			. = 1

/mob/living/carbon/human/mob_negates_gravity()
	return shoes && shoes.negates_gravity()

/mob/living/carbon/human/Move(NewLoc, direct)
	..()
	if(shoes)
		if(!lying)
			if(loc == NewLoc)
				var/obj/item/clothing/shoes/S = shoes

				S.step_action(src)
	if(nearcrit) //You can only crawl in nearcrit
		adjustOxyLoss(2)
		// if(dir == WEST)
		// 	lying = 90
		// else if(dir == EAST)
		// 	lying = 270

		visible_message("<span class='danger'>[src] crawls forward!</span>", \
						"<span class='userdanger'>You crawl forward.</span>")