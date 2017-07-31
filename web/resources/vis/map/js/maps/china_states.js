/**
*
* Jquery Mapael - Dynamic maps jQuery plugin (based on raphael.js)
* Requires jQuery and raphael.js
*
* Map of USA by state
* 
* @source http://the55.net/_11/sketch/us_map
*/
(function($) {
	$.extend(true, $.fn.mapael, 
		{
			maps :{
				china_states : {
					width : 1000,
					height : 850,
					latLngToGrid: function(lat, lng, phi1, phi2, midLng, scale) {
						var pi =Math.PI
							, midLat = (phi1 + phi2) / 2
							, n, tmp1, tmp2, tmp3, x, y, p;

						n = (Math.sin(phi1 / 180 * pi) + Math.sin(phi2 / 180 * pi)) / 2;
						tmp1 = Math.sqrt(Math.cos(phi1 / 180 * pi)) + 2 * n * Math.sin(phi1 / 180 * pi);
						tmp2 = scale * Math.pow(tmp1 - 2 * n * Math.sin(midLat / 180 * pi),0.5) / n;
						tmp3 = n * (lng - midLng);
						p = scale * Math.pow(tmp1 - 2 * n * Math.sin(lat / 180 * pi),0.5) / n;
						x = p * Math.sin(tmp3 / 180 * pi);
						y = tmp2 - p * Math.cos(tmp3 / 180 * pi);
						
						return([x,y]);
					},
					getCoords : function (lat, lon) {
						var coords = {};
						if(lat > 51) { // alaska

							// these are guesses
							var phi1= 15; // standard parallels
							var phi2= 105;
							var midLng = -134;
							var scale = 530;
							coords = this.latLngToGrid(lat, lon, phi1, phi2, midLng, scale);
							xOffset = 190;
							yOffset = 543;
							scaleX= 1;
							scaleY= -1;

						} else if (lon < -140) { // hawaii
							// Lat: 18�?55' N to 28�?27' N, Lng:154�?48' W to 178�?22' W
							// (225, 504) to (356, 588) on map

							// these are guesses
							var phi1= 0; // standard parallels
							var phi2= 26;
							var midLng = -166;
							var scale = 1280;
							coords = this.latLngToGrid(lat, lon, phi1, phi2, midLng, scale);
							xOffset = 115;
							yOffset = 723;
							scaleX= 1;
							scaleY= -1;
						} else {
							xOffset = -17;
							yOffset = -22;
							scaleX = 10.05;
							scaleY = 6.26;

							coords[0] = 50.0 + 124.03149777329222 * ((1.9694462586094064-(lat* Math.PI / 180)) * Math.sin(0.6010514667026994 * (lon + 96) * Math.PI / 180));
							coords[1] = 50.0 + 1.6155950752393982 * 124.03149777329222 * 0.02613325650382181 - 1.6155950752393982* 124.03149777329222 * (1.3236744353715044- (1.9694462586094064-(lat* Math.PI / 180)) * Math.cos(0.6010514667026994 * (lon + 96) * Math.PI / 180));
						}
						return {x : (coords[0] * scaleX + xOffset), y : (coords[1] * scaleY + yOffset)};
					},
					elems : {
						"北京" : "M389 150L389 146L389 145L392 140L395 138L399 136L402 137L404 140L404 143L407 145L407 148L405 150L402 149L400 150L398 149L394 150L391 150L389 150Z",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
						"上海" : "M450 231L447 232L447 234L447 237L448 239L449 240L451 240L453 237L454 236L455 234L454 232L451 231L450 231Z",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
						"天津" : "M402 151L401 154L402 157L404 159L407 161L408 159L408 156L410 154L410 151L407 150L405 150L402 151Z",                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
						"广东" : "M351 346L351 347L350 350L352 352L352 354L354 357L356 358L358 357L358 355L355 352L357 350L358 349L359 347L361 347L364 345L366 345L368 344L370 344L371 344L374 344L376 342L378 342L380 341L383 339L385 337L386 335L388 335L389 332L391 332L392 334L394 335L397 335L398 333L399 332L401 331L404 331L406 331L408 331L409 329L412 328L415 326L416 325L417 323L417 322L418 321L420 319L422 318L421 317L421 314L419 312L417 310L415 308L412 307L409 307L408 310L406 310L404 310L402 310L400 311L397 311L395 312L395 309L396 307L397 305L398 304L398 302L395 303L393 303L392 304L389 304L388 303L386 303L381 303L380 305L383 307L382 309L380 309L378 307L378 305L375 305L374 308L374 310L372 313L372 315L372 317L371 320L369 321L369 323L368 327L366 329L364 331L363 332L361 334L359 336L357 338L355 339L353 341L351 346Z",                                                                                                                                                                                                                                             
						"福建" : "M410 308L413 308L415 309L418 312L419 313L422 317L425 317L426 314L427 312L429 311L430 310L432 310L432 306L434 306L436 305L438 303L438 301L439 301L440 299L440 298L442 297L444 297L443 295L442 294L442 292L443 290L445 289L443 286L441 284L444 284L445 284L446 282L446 280L448 279L448 277L446 276L441 277L439 277L437 277L435 277L434 275L434 273L433 271L432 269L431 269L429 269L428 271L426 272L424 273L421 273L419 275L419 277L419 280L418 283L416 283L415 285L413 287L413 290L413 293L412 294L411 296L410 299L411 301L410 304L410 306L410 308Z",
						"海南" : "M346 365L345 368L342 370L342 372L342 375L341 376L344 378L346 380L348 380L351 381L353 378L356 378L358 375L360 373L360 371L362 368L364 367L364 364L364 363L363 361L360 362L357 362L355 362L353 362L350 364L350 365L348 365L346 365Z",
						"安徽" : "M407 253L409 252L409 249L412 250L413 253L413 255L415 255L416 252L418 253L419 255L420 255L422 255L425 255L427 254L428 252L430 250L430 247L431 245L433 244L432 242L432 241L436 240L437 238L435 236L431 236L429 234L428 233L425 231L424 229L425 227L425 225L426 223L429 223L430 220L429 219L427 218L425 220L423 220L421 218L420 216L420 214L418 212L417 211L415 211L411 210L410 209L409 207L407 203L405 202L403 203L402 204L403 205L404 206L405 208L405 210L405 211L403 212L401 212L400 211L399 209L398 209L397 212L397 215L396 217L395 218L394 219L394 221L396 223L396 225L398 226L400 226L401 226L402 228L402 230L402 233L401 234L399 234L398 236L399 239L401 241L402 241L402 242L402 245L404 247L404 250L407 253Z",
						"贵州" : "M303 313L307 310L311 310L314 312L318 312L321 310L324 307L325 304L328 304L333 307L335 307L339 307L343 303L347 300L350 299L350 297L347 294L346 288L346 287L343 287L341 287L341 285L343 284L346 283L346 281L346 278L344 276L342 275L340 273L337 270L337 267L335 264L330 264L329 267L328 269L327 270L325 272L324 272L321 272L318 272L316 272L314 271L312 272L312 274L316 276L318 277L318 281L317 283L312 282L310 282L308 284L305 285L304 285L300 283L298 284L296 285L294 288L295 292L298 292L301 293L302 295L301 299L299 302L300 304L303 306L303 310L303 313L303 313Z",
						"甘肃" : "M210 153L209 150L208 146L209 143L210 141L215 141L217 140L218 137L219 136L221 135L221 133L223 131L226 130L231 130L235 129L235 126L236 120L238 119L240 118L242 119L246 119L247 120L247 123L250 127L251 130L249 134L250 137L253 139L254 142L255 144L257 143L260 142L263 141L267 141L268 142L268 145L264 150L265 152L267 154L270 157L272 159L276 165L280 165L280 162L281 160L287 159L289 160L296 156L299 157L300 160L297 163L294 166L293 171L296 176L300 178L302 178L305 181L308 184L309 187L309 195L314 198L317 198L320 195L322 194L321 190L319 189L318 186L320 183L320 181L322 180L325 179L325 182L326 184L329 185L331 186L333 187L337 190L335 192L336 199L334 201L332 201L330 203L326 203L323 203L318 203L318 209L320 212L320 218L317 219L314 220L314 222L315 223L315 226L314 227L311 228L310 229L304 229L301 226L298 221L292 215L290 214L288 211L285 213L284 216L284 217L280 220L277 219L275 217L272 215L271 211L271 209L274 209L277 211L282 211L282 208L279 206L281 204L284 201L284 198L288 194L288 192L287 188L285 180L283 176L278 175L274 173L271 171L269 167L266 166L262 166L259 163L255 162L251 160L249 160L246 158L242 158L241 160L241 164L239 165L233 162L226 156L223 154L219 154L213 154L210 153L210 153Z",
						"广西" : "M303 314L305 316L307 318L311 319L314 319L316 321L316 324L314 326L311 326L311 330L313 332L316 331L320 332L323 334L321 338L323 340L323 342L326 345L328 346L331 346L337 346L340 346L340 343L341 343L344 346L346 348L349 346L351 346L352 344L353 341L356 340L360 336L364 331L368 327L369 324L369 322L370 320L372 318L372 316L372 313L371 312L366 312L365 309L363 308L363 306L364 303L366 301L363 298L362 296L361 295L357 295L356 297L354 299L352 299L350 299L346 301L342 302L342 304L337 306L333 307L331 306L328 304L326 304L325 307L322 310L320 312L318 313L315 312L312 310L307 309L305 311L304 313L303 314Z",
						"河北" : "M380 186L383 187L386 187L389 187L392 187L394 187L394 185L392 183L393 181L394 180L395 177L397 175L400 173L402 171L403 170L405 168L407 166L409 166L410 163L409 162L407 161L405 159L403 157L402 155L402 153L401 151L399 149L397 149L396 149L395 151L392 151L390 151L389 150L389 148L389 146L391 146L392 145L393 143L393 141L393 140L395 138L398 138L398 138L400 137L403 137L404 139L404 141L404 143L405 144L407 145L407 149L408 150L410 152L411 154L414 154L417 153L417 153L419 151L421 149L423 148L424 145L424 143L424 141L422 139L420 138L418 137L416 136L415 134L416 133L418 131L418 130L417 130L414 130L411 130L410 128L409 126L408 124L407 121L405 118L403 117L401 119L400 119L399 121L398 123L398 126L396 127L394 127L391 127L390 128L389 130L387 130L386 132L385 132L383 131L383 129L384 127L382 126L381 125L380 125L379 126L379 128L379 130L378 131L376 131L376 134L376 136L376 138L377 140L377 141L378 143L380 144L379 146L377 147L378 149L380 149L380 151L382 155L382 157L380 159L377 160L377 162L376 164L376 166L378 167L379 168L380 171L380 174L380 178L378 181L376 183L378 185L379 187L380 186Z",
						"河南" : "M358 222L362 226L365 228L367 229L371 228L375 229L378 229L382 231L384 234L387 234L389 235L392 235L394 237L397 237L398 237L399 236L401 234L403 233L403 230L402 227L400 226L397 226L396 226L396 223L395 222L394 220L395 218L396 217L397 216L398 212L398 209L400 210L402 213L403 213L404 211L405 209L405 207L403 205L402 203L400 204L398 204L396 204L394 202L392 199L391 198L392 196L393 195L395 192L394 190L394 188L392 188L389 188L387 188L384 188L382 187L379 186L379 189L378 191L377 193L376 195L374 197L373 197L370 198L368 198L367 199L366 199L364 200L362 201L359 203L355 203L354 205L354 208L354 211L355 213L356 215L357 218L358 222Z",
						"黑龙江" : "M412 8L413 10L411 13L411 14L414 17L416 16L416 14L419 14L422 16L422 19L424 22L425 24L429 23L432 22L435 20L436 18L439 18L442 20L443 25L444 28L442 32L442 35L442 38L444 41L443 43L443 47L445 49L445 53L443 55L441 54L441 51L438 49L437 53L436 56L435 59L432 63L431 64L433 68L436 70L439 69L440 71L438 73L437 74L438 76L441 75L443 78L445 81L447 82L450 83L453 81L456 79L458 77L460 80L460 82L462 83L465 82L468 84L470 85L472 88L474 90L476 88L478 86L482 90L484 94L487 94L489 92L490 91L492 89L495 88L497 90L501 92L503 92L503 90L503 87L502 85L501 83L500 82L500 79L499 77L499 75L501 73L504 72L507 72L510 72L511 71L512 68L511 65L511 62L512 60L512 57L512 54L512 52L513 49L514 46L514 43L512 41L511 40L511 36L511 33L509 33L506 35L504 36L501 38L499 40L498 42L496 43L494 45L492 47L491 47L488 48L485 47L483 45L482 41L480 38L477 38L475 37L472 35L470 34L467 35L465 34L460 33L458 34L458 32L457 30L454 28L454 26L454 24L451 22L450 20L448 19L447 16L446 14L444 13L442 10L441 8L439 6L438 5L436 3L434 3L432 3L430 3L428 3L425 2L422 0L419 2L417 2L413 4L412 8Z",
						"湖北" : "M345 265L347 264L349 261L350 259L352 259L355 259L356 258L356 257L355 254L357 253L359 254L361 255L364 256L366 257L369 258L371 259L374 259L376 259L377 257L380 259L382 262L385 262L388 264L389 262L391 261L393 261L395 260L396 258L399 256L403 254L406 253L406 253L405 250L404 248L402 245L402 244L403 241L399 240L398 237L397 237L394 237L391 235L389 234L385 234L384 232L381 230L379 229L376 229L373 229L371 229L367 229L366 228L363 226L361 224L359 222L358 222L355 222L352 221L349 221L347 222L347 223L349 225L350 227L349 229L347 229L346 230L346 233L346 236L347 237L348 238L351 240L351 240L354 243L354 245L351 246L348 248L346 249L342 249L338 250L338 253L337 255L337 258L340 260L343 263L345 265Z",
						"湖南" : "M371 313L374 311L374 307L376 306L379 308L382 309L383 307L381 305L381 304L385 304L390 304L390 302L390 297L390 293L389 288L387 284L385 280L386 277L388 275L390 271L390 268L387 264L384 262L382 261L379 259L378 257L375 260L372 260L368 257L364 256L360 255L356 254L355 254L356 258L354 259L351 259L349 261L347 264L346 264L345 268L345 271L345 275L345 277L347 279L346 283L344 284L341 284L341 287L343 287L347 287L347 291L347 294L350 297L350 299L353 299L355 297L358 296L361 296L364 298L365 300L365 302L363 306L362 308L365 308L366 311L368 312L371 312L371 313Z",
						"吉林" : "M447 103L450 104L452 106L455 108L456 107L456 105L457 105L459 106L459 110L461 112L463 115L464 115L464 120L468 123L470 126L472 123L473 122L473 119L475 116L478 118L481 118L483 118L486 118L486 116L486 113L484 112L485 110L487 110L490 109L491 106L492 103L493 101L494 99L497 99L497 103L499 103L501 104L502 103L503 99L504 98L504 94L504 92L501 92L499 92L496 90L496 88L494 88L491 89L489 90L488 92L487 93L485 93L482 92L480 88L478 87L476 87L475 90L474 89L471 87L470 85L467 84L466 82L463 82L461 82L459 82L459 78L459 77L456 79L454 80L451 82L448 82L445 81L443 78L441 76L439 76L437 79L434 81L429 78L427 78L427 80L428 82L430 84L432 86L432 89L433 92L434 94L436 97L438 95L440 93L440 92L442 94L443 97L444 100L445 102L447 103Z",
						"江苏" : "M433 244L435 245L436 245L438 244L440 244L442 244L443 244L445 243L446 242L449 240L447 240L446 237L446 235L447 233L447 232L448 231L450 230L450 229L450 228L448 228L448 228L448 227L450 226L452 227L454 227L454 226L452 224L449 222L447 220L446 219L444 219L444 216L442 214L440 210L439 208L437 205L437 203L435 202L432 201L429 198L428 196L427 195L426 195L424 196L422 198L422 200L421 201L420 201L418 201L416 202L415 203L413 203L412 203L410 201L409 200L408 199L406 198L405 199L404 201L404 202L405 202L407 205L408 206L409 208L412 209L414 210L416 210L418 210L418 213L420 215L421 218L423 221L425 221L427 219L429 219L429 220L429 222L429 223L427 223L425 224L425 227L423 230L424 231L428 234L431 236L434 236L436 237L436 239L436 240L433 241L432 243L433 244Z",
						"江西" : "M390 303L394 303L396 303L398 304L398 306L396 307L394 309L394 311L397 312L400 311L402 310L405 309L407 310L409 309L410 308L410 306L410 305L410 303L411 301L411 298L411 296L412 295L414 293L414 290L414 286L415 284L417 283L419 282L419 279L419 277L419 276L420 274L422 274L425 273L428 271L429 269L429 267L428 264L426 261L424 259L424 257L425 257L427 255L426 254L424 254L422 254L419 254L417 253L416 252L416 253L415 255L413 254L413 251L412 250L409 250L407 252L406 254L404 254L402 254L400 255L396 258L395 259L394 260L392 261L390 261L388 263L389 265L390 267L390 269L390 272L389 274L388 275L385 278L386 281L387 283L388 286L389 288L390 291L390 294L390 298L390 303Z",
						"辽宁" : "M425 142L427 140L429 138L431 136L433 133L434 132L438 132L440 133L441 135L442 138L441 140L439 142L438 144L440 147L441 149L440 150L438 152L437 153L439 154L442 154L444 152L444 149L445 147L446 146L447 144L449 143L453 141L455 141L458 140L459 137L459 135L461 133L463 131L466 129L469 126L471 125L467 123L465 121L464 120L464 118L464 116L463 114L461 113L460 111L459 109L458 108L458 106L457 104L455 105L455 107L454 108L451 106L450 104L447 104L447 106L447 108L447 109L445 111L444 110L442 109L441 109L439 110L438 111L437 113L436 114L434 115L432 117L430 119L428 120L424 123L422 123L421 121L420 119L419 119L418 119L418 122L418 125L419 127L419 129L418 131L417 132L416 134L416 135L417 137L420 138L421 140L424 142L425 142Z",
						"内蒙古" : "M248 120L248 120L248 120L249 126L249 126L249 126L251 128L251 128L251 128L251 131L251 131L251 131L249 136L249 136L249 136L253 138L253 138L253 138L255 143L255 143L255 143L255 145L255 145L255 145L257 144L257 144L257 144L259 142L259 142L259 142L263 142L263 142L263 142L267 142L267 142L267 142L268 143L268 143L268 143L266 148L266 148L266 148L264 149L264 149L264 149L264 151L264 151L264 151L266 152L266 152L266 152L269 155L269 155L269 155L272 159L272 159L272 159L273 162L273 162L273 162L277 165L277 165L277 165L280 165L280 165L280 165L280 161L280 161L280 161L282 160L282 160L282 160L285 160L285 160L285 160L289 160L289 160L289 160L290 160L290 160L290 160L292 158L292 158L292 158L294 158L294 158L294 158L298 158L298 158L298 158L300 160L300 160L300 160L297 163L297 163L297 163L295 166L295 166L295 166L294 169L294 169L294 169L294 173L294 173L294 173L297 178L297 178L297 178L302 177L302 177L302 177L306 175L306 175L306 175L308 173L308 173L308 173L312 172L312 172L312 172L313 169L313 169L313 169L313 166L313 166L313 166L314 163L314 163L314 163L317 160L317 160L317 160L319 158L319 158L319 158L321 159L321 159L321 159L322 161L322 161L322 161L321 165L321 165L321 165L320 169L320 169L320 169L322 173L322 173L322 173L326 173L326 173L326 173L331 174L331 174L331 174L336 174L336 174L336 174L339 172L339 172L339 172L339 167L339 167L339 167L341 165L341 165L341 165L344 162L344 162L344 162L346 159L346 159L346 159L347 156L347 156L347 156L350 156L350 156L350 156L353 156L353 156L353 156L356 156L356 156L356 156L359 154L359 154L359 154L361 150L361 150L361 150L364 148L364 148L364 148L366 146L366 146L366 146L371 146L371 146L371 146L374 146L374 146L374 146L377 143L377 143L377 143L377 141L377 141L377 141L377 138L377 138L377 138L377 134L377 134L377 134L377 131L377 131L377 131L378 130L378 130L378 130L380 126L380 126L380 126L383 126L383 126L383 126L383 131L383 131L383 131L385 134L385 134L385 134L388 131L388 131L388 131L389 129L389 129L389 129L393 128L393 128L393 128L396 126L396 126L396 126L399 126L399 126L399 126L398 123L398 123L398 123L401 121L401 121L401 121L405 115L405 115L405 115L408 119L408 119L408 119L408 122L408 122L408 122L410 128L410 128L410 128L414 130L414 130L414 130L418 131L418 131L418 131L418 126L418 126L418 126L418 122L418 122L418 122L418 118L418 118L418 118L421 122L421 122L421 122L424 123L424 123L424 123L426 122L426 122L426 122L429 120L429 120L429 120L432 117L432 117L432 117L436 115L436 115L436 115L436 112L436 112L436 112L439 110L439 110L439 110L445 110L445 110L445 110L447 110L447 110L447 110L447 105L447 105L447 105L447 103L447 103L447 103L444 100L444 100L444 100L442 96L442 96L442 96L441 92L441 92L441 92L438 93L438 93L438 93L436 95L436 95L436 95L435 95L435 95L435 95L433 91L433 91L433 91L433 88L433 88L433 88L432 86L432 86L432 86L428 82L428 82L428 82L428 79L428 79L428 79L433 80L433 80L433 80L436 80L436 80L436 80L438 77L438 77L438 77L438 75L438 75L438 75L438 74L438 74L438 74L440 72L440 72L440 72L440 70L440 70L440 70L439 68L439 68L439 68L437 69L437 69L437 69L432 68L432 68L432 68L431 66L431 66L431 66L431 63L431 63L431 63L434 60L434 60L434 60L436 55L436 55L436 55L439 51L439 51L439 51L440 49L440 49L440 49L441 54L441 54L441 54L443 54L443 54L443 54L444 50L444 50L444 50L444 47L444 47L444 47L442 44L442 44L442 44L444 42L444 42L444 42L442 37L442 37L442 37L442 34L442 34L442 34L444 29L444 29L444 29L444 24L444 24L444 24L441 18L441 18L441 18L437 17L437 17L437 17L435 20L435 20L435 20L432 21L432 21L432 21L429 23L429 23L429 23L425 23L425 23L425 23L422 20L422 20L422 20L421 15L421 15L421 15L418 14L418 14L418 14L415 18L415 18L415 18L413 16L413 16L413 16L411 13L411 13L411 13L414 9L414 9L414 9L412 8L412 8L412 8L408 7L408 7L408 7L404 10L404 10L404 10L403 12L403 12L403 12L405 16L405 16L405 16L407 19L407 19L407 19L407 23L407 23L407 23L405 23L405 23L405 23L404 26L404 26L404 26L402 29L402 29L402 29L402 32L402 32L402 32L402 37L402 37L402 37L402 39L402 39L402 39L401 41L401 41L401 41L399 41L399 41L399 41L395 44L395 44L395 44L392 45L392 45L392 45L386 45L386 45L386 45L383 49L383 49L383 49L383 53L383 53L383 53L381 58L381 58L381 58L380 62L380 62L380 62L380 67L380 67L380 67L383 68L383 68L383 68L387 67L387 67L387 67L390 67L390 67L390 67L395 67L395 67L395 67L397 64L397 64L397 64L399 61L399 61L399 61L402 62L402 62L402 62L404 65L404 65L404 65L408 67L408 67L408 67L409 69L409 69L409 69L410 69L410 69L410 69L413 73L413 73L413 73L413 75L413 75L413 75L408 75L408 75L408 75L403 75L403 75L403 75L400 75L400 75L400 75L396 75L396 75L396 75L394 79L394 79L394 79L391 80L391 80L391 80L388 84L388 84L388 84L386 88L386 88L386 88L381 89L381 89L381 89L377 91L377 91L377 91L373 94L373 94L373 94L371 96L371 96L371 96L367 98L367 98L367 98L363 99L363 99L363 99L360 97L360 97L360 97L357 97L357 97L357 97L354 101L354 101L354 101L356 105L356 105L356 105L357 108L357 108L357 108L359 110L359 110L359 110L354 114L354 114L354 114L352 116L352 116L352 116L349 118L349 118L349 118L347 119L347 119L347 119L344 122L344 122L344 122L339 124L339 124L339 124L337 125L337 125L337 125L328 125L328 125L328 125L326 125L326 125L326 125L320 128L320 128L320 128L315 131L315 131L315 131L311 131L311 131L311 131L306 133L306 133L306 133L303 133L303 133L303 133L298 133L298 133L298 133L291 130L291 130L291 130L287 130L287 130L287 130L282 126L282 126L282 126L278 123L278 123L278 123L270 122L270 122L270 122L264 122L264 122L264 122L254 121L254 121L254 121L249 118L249 118L249 118L250 121L250 121L250 121L249 121L249 121L249 121L248 120Z",
						"宁夏" : "M301 178L305 180L308 183L308 184L309 190L309 194L311 196L314 199L317 198L320 195L321 193L322 191L319 190L318 188L319 186L320 183L320 181L321 180L323 179L325 177L327 175L325 173L323 171L320 171L319 170L319 167L321 164L322 161L322 159L320 158L318 158L315 161L313 164L313 167L312 170L312 172L309 172L308 174L307 174L304 175L302 175L301 178Z",
						"青海" : "M176 184L177 187L176 190L176 192L175 199L176 203L177 207L178 209L181 213L185 214L188 214L191 218L195 219L198 220L202 223L207 224L214 224L220 226L222 231L225 236L228 236L229 235L233 236L235 235L237 233L239 229L240 229L240 225L242 222L242 219L240 217L240 214L248 214L251 218L251 221L254 224L257 226L260 227L262 226L265 227L267 229L269 230L271 227L275 227L275 224L274 222L273 219L274 217L271 214L270 210L275 210L278 211L281 211L281 209L279 207L281 204L283 201L285 199L288 196L289 195L287 191L287 188L286 184L285 181L284 178L282 174L277 174L274 173L271 172L268 168L267 166L263 166L260 164L256 161L250 161L248 160L245 158L242 158L241 163L238 165L234 162L230 159L226 157L222 154L215 154L211 153L206 154L201 155L198 156L194 158L191 158L186 158L185 160L186 162L186 164L189 167L193 171L192 174L190 176L188 180L190 182L189 184L185 184L181 181L179 183L177 183L176 184Z",
						"山东" : "M402 203L404 203L404 202L404 200L405 199L407 198L409 200L410 202L411 204L413 204L415 204L416 204L418 202L419 201L421 201L422 201L422 199L423 197L425 196L426 194L428 194L429 194L429 192L429 190L431 188L433 186L433 185L435 183L437 181L439 179L440 177L442 176L445 174L446 172L448 172L451 171L451 170L449 167L446 167L442 167L440 167L437 167L434 165L432 166L430 168L429 170L427 172L427 173L425 174L423 173L420 171L420 169L420 167L418 166L417 166L415 166L412 166L411 166L409 166L409 165L407 166L405 167L404 169L401 170L401 172L398 174L397 175L396 177L394 179L393 181L393 185L393 188L395 190L395 194L393 195L392 198L392 199L394 201L395 203L398 204L401 204L402 203Z",
						"山西" : "M353 205L356 205L358 202L361 202L364 201L366 200L370 199L373 197L376 195L378 193L379 190L379 187L376 184L377 182L380 179L381 176L381 172L381 170L379 168L378 167L376 165L376 163L379 160L381 158L383 156L382 154L381 151L379 149L378 147L379 146L380 145L378 143L377 143L375 144L372 146L369 146L366 146L364 148L363 150L360 153L358 155L357 156L356 159L355 162L355 164L353 167L352 169L353 172L353 175L353 179L351 181L351 184L351 189L352 193L352 196L352 200L352 204L353 205Z",
						"陕西" : "M314 227L317 228L319 228L322 228L325 231L327 230L330 233L333 232L337 232L340 234L343 237L346 236L347 230L349 228L350 225L346 222L350 222L354 222L359 222L359 219L357 216L356 213L354 210L354 205L351 203L351 200L352 198L352 194L351 190L351 187L351 183L353 179L354 175L352 171L352 168L355 164L355 162L356 159L356 158L356 156L354 155L351 156L350 157L348 156L346 158L345 160L343 162L341 164L340 166L339 169L339 172L339 175L336 175L333 175L330 175L328 175L327 175L325 178L325 180L325 183L326 184L328 184L331 185L335 188L337 189L336 192L336 196L336 200L334 201L332 202L329 203L327 203L325 203L323 203L319 203L318 204L318 207L318 210L319 212L319 215L319 218L318 219L314 219L313 220L315 222L315 224L314 227Z",
						"四川" : "M240 229L240 229L240 226L240 226L242 223L242 223L242 220L242 220L241 217L241 217L241 215L241 215L248 214L248 214L251 217L251 217L252 221L252 221L252 222L252 222L255 225L255 225L257 226L257 226L260 227L260 227L263 226L263 226L265 228L265 228L266 228L266 228L268 230L268 230L271 228L271 228L273 228L273 228L274 225L274 225L274 221L274 221L273 220L273 220L274 218L274 218L279 221L279 221L283 221L283 221L284 219L284 219L284 217L284 217L283 215L283 215L285 213L285 213L288 212L288 212L290 214L290 214L291 216L291 216L293 217L293 217L295 219L295 219L299 221L299 221L300 225L300 225L303 228L303 228L305 229L305 229L310 229L310 229L312 227L312 227L315 227L315 227L319 229L319 229L322 229L322 229L325 231L325 231L327 231L327 231L330 233L330 233L329 234L329 234L329 238L329 238L326 243L326 243L326 245L326 245L324 248L324 248L322 250L322 250L319 251L319 251L317 251L317 251L313 248L313 248L311 247L311 247L311 251L311 251L311 253L311 253L311 256L311 256L311 261L311 261L314 265L314 265L315 267L315 267L314 270L314 270L311 272L311 272L313 274L313 274L316 275L316 275L319 278L319 278L318 281L318 281L311 282L311 282L310 281L310 281L309 277L309 277L307 277L307 277L304 279L304 279L302 278L302 278L299 274L299 274L299 271L299 271L296 271L296 271L295 271L295 271L293 274L293 274L291 275L291 275L291 277L291 277L292 279L292 279L292 282L292 282L288 285L288 285L287 287L287 287L287 290L287 290L290 293L290 293L289 296L289 296L285 298L285 298L281 300L281 300L280 299L280 299L275 297L275 297L272 295L272 295L273 292L273 292L274 290L274 290L273 288L273 288L270 284L270 284L268 281L268 281L267 279L267 279L264 279L264 279L262 277L262 277L260 273L260 273L260 270L260 270L258 269L258 269L256 270L256 270L256 274L256 274L254 274L254 274L253 272L253 272L253 269L253 269L251 267L251 267L253 263L252 259L251 256L254 252L253 248L251 246L250 242L248 239L246 235L245 233L243 231L241 229L240 229Z",
						"西藏" : "M86 181L90 183L93 183L96 180L96 177L99 175L104 174L109 178L114 178L117 175L121 175L122 178L126 181L128 182L132 181L137 179L141 179L147 180L150 177L153 175L156 176L161 176L169 177L175 181L175 183L178 188L176 193L176 200L176 205L178 210L184 213L188 215L193 218L196 221L202 223L208 224L214 224L220 226L223 233L226 237L230 234L232 236L236 233L239 230L240 229L244 231L249 239L252 244L254 248L253 253L251 257L253 260L252 266L251 268L250 265L247 266L247 272L245 274L242 272L239 271L237 271L236 276L232 277L230 274L227 273L225 272L222 271L220 271L218 273L215 274L212 276L209 279L205 281L203 283L199 283L189 284L187 283L185 281L186 277L186 276L183 274L183 272L181 272L179 272L177 270L175 269L172 267L170 266L167 268L165 269L163 271L162 275L160 275L157 275L157 271L157 268L157 267L156 265L153 266L151 267L149 268L146 268L145 268L142 267L142 265L140 263L136 263L133 263L131 262L130 259L129 258L127 257L124 255L121 254L120 252L119 248L119 245L116 245L113 245L110 242L109 240L107 237L105 235L103 234L101 232L100 231L97 233L94 233L92 233L90 230L89 228L88 225L87 223L86 221L83 219L78 217L75 216L75 213L75 211L77 210L77 206L77 201L78 199L81 202L84 203L84 199L85 195L83 192L82 188L83 186L84 183L86 181Z",
						"新疆" : "M86 181L86 181L91 184L91 184L93 183L93 183L96 181L96 181L97 179L97 179L98 177L98 177L100 174L100 174L103 174L103 174L107 177L107 177L108 178L108 178L112 179L112 179L115 178L115 178L119 175L119 175L122 175L122 175L122 180L122 180L124 181L124 181L129 182L129 182L131 181L131 181L135 181L135 181L138 179L138 179L140 180L140 180L144 180L144 180L147 180L147 180L149 178L149 178L153 175L153 175L158 177L158 177L161 177L161 177L165 177L165 177L168 177L168 177L171 179L171 179L175 180L175 180L176 183L176 183L177 184L177 184L180 183L180 183L182 182L182 182L186 184L186 184L189 184L189 184L190 182L190 182L189 179L189 179L189 177L189 177L192 174L192 174L193 170L193 170L191 168L191 168L188 166L188 166L187 164L187 164L187 162L187 162L186 159L186 159L189 159L189 159L193 159L193 159L197 158L197 158L200 156L200 156L202 155L202 155L207 154L207 154L210 154L210 154L209 151L209 151L208 148L208 148L208 145L208 145L210 143L210 143L211 140L211 140L214 142L214 142L218 140L218 140L219 137L219 137L221 133L221 133L223 131L223 131L227 131L227 131L231 131L231 131L235 128L235 128L237 127L237 127L237 123L237 123L238 118L238 118L238 114L238 114L236 111L236 111L234 108L234 108L234 105L234 105L231 102L231 102L228 101L228 101L225 98L225 98L223 96L223 96L221 94L221 94L218 93L218 93L214 93L214 93L212 93L212 93L209 91L209 91L207 90L207 90L205 89L205 89L203 87L203 87L201 83L201 83L203 80L203 80L206 77L206 77L206 74L206 74L206 70L206 70L203 67L203 67L203 64L203 64L201 60L201 60L198 58L198 58L195 57L195 57L193 57L193 57L192 56L192 56L190 52L190 52L188 50L188 50L188 46L188 46L186 44L186 44L183 44L183 44L181 47L181 47L180 50L180 50L177 50L177 50L172 50L172 50L171 53L171 53L170 54L170 54L169 59L169 59L168 62L168 62L164 64L164 64L162 64L162 64L159 62L159 62L158 62L158 62L156 59L156 59L154 58L154 58L150 59L150 59L148 61L148 61L146 63L146 63L145 66L145 66L142 70L142 70L142 74L142 74L142 78L142 78L139 78L139 78L135 75L135 75L130 75L130 75L127 75L127 75L124 76L124 76L123 81L123 81L123 84L123 84L123 89L123 89L123 91L123 91L123 94L123 94L121 96L121 96L118 97L118 97L117 102L117 102L115 104L115 104L112 106L112 106L107 108L107 108L104 108L104 108L100 108L100 108L97 108L97 108L93 108L93 108L93 111L93 111L90 111L90 111L88 111L88 111L86 114L86 114L84 114L84 114L81 114L81 114L78 111L78 111L76 109L76 109L73 110L73 110L71 111L71 111L66 111L66 111L63 113L63 113L59 116L59 116L59 119L59 119L60 122L60 122L58 123L58 123L57 123L57 123L56 126L56 126L59 127L59 127L63 127L63 127L64 128L64 128L65 131L65 131L65 134L65 134L65 139L65 139L61 141L61 141L60 143L60 143L61 146L61 146L65 147L65 147L67 150L67 150L68 153L68 153L68 154L68 154L68 158L68 158L69 161L69 161L71 161L71 161L72 165L72 165L77 167L77 167L79 167L79 167L80 170L80 170L80 173L80 173L82 177L82 177L86 180L86 180L86 181L86 181Z",
						"云南" : "M252 267L252 270L253 273L255 274L256 272L256 269L257 268L259 270L261 274L262 277L267 279L271 287L274 289L273 291L273 295L276 298L280 299L284 298L288 296L289 293L287 290L287 286L291 282L292 279L291 275L293 272L294 271L298 272L301 277L304 278L308 277L309 279L309 282L307 284L305 285L302 283L298 283L295 286L295 293L301 293L302 294L301 298L300 302L301 305L303 307L302 312L304 315L306 317L310 319L312 320L316 321L316 323L314 327L311 326L308 327L305 330L303 331L301 332L298 334L295 336L293 334L291 334L288 335L285 335L282 333L281 335L278 336L275 335L274 338L275 342L275 345L275 349L274 351L270 348L268 345L268 343L266 343L263 344L261 345L259 343L256 340L255 339L251 339L251 336L251 332L251 328L249 328L247 326L246 321L244 318L244 317L240 317L239 319L237 319L235 316L235 314L235 310L236 308L237 305L240 303L243 302L245 299L247 292L247 289L248 285L248 283L245 281L244 277L244 275L246 274L247 272L247 269L247 266L249 265L251 267L252 267Z",
						"浙江" : "M429 268L432 270L433 271L433 275L435 276L437 277L441 277L442 276L444 276L447 276L449 276L449 274L450 271L450 270L451 268L453 266L453 266L456 267L456 265L456 262L456 259L456 257L454 256L455 255L456 254L458 254L459 252L457 251L454 251L455 250L456 249L458 247L458 245L454 244L452 245L451 244L449 244L447 245L445 245L444 244L442 244L441 244L439 244L438 244L436 244L433 244L432 245L431 247L431 249L429 251L427 253L425 254L425 257L425 260L427 262L428 264L428 265L429 268Z",
						"重庆" : "M314 271L318 273L320 273L322 273L325 272L326 269L328 268L330 263L333 264L336 264L337 267L339 270L341 274L343 275L345 277L345 273L345 268L345 265L343 263L342 262L339 259L338 257L338 255L338 252L338 250L342 249L346 250L348 249L350 247L352 245L353 244L353 242L351 241L348 238L346 237L344 237L342 236L340 234L338 232L335 232L332 232L330 232L330 237L328 240L327 242L326 244L325 247L323 248L321 251L320 251L317 251L315 249L313 247L311 247L310 250L311 252L312 254L311 257L311 259L312 262L313 264L314 265L315 266L314 271Z",
						"澳门" : "M387 336L386 340L391 345L387 336Z"    
					}
				}
			}
		}
	);
})(jQuery);