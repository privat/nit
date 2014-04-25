# This file is part of NIT ( http://www.nitlanguage.org ).
#
# Copyright 2014 Johann DUBOIS <johann.dubois@outlook.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Module du context du composant "multiplication" qui contient les spécification SCA
# Celui ci est appelé lors de la réception d'une requête
module multiplicationContext


import sca
import multiplication

# Composant multiplication
class MultiplicationContext
	super SCAComponentImp 
	super Multiplication
	
	init with_name(name:String) do
		# ajout du service
		var multiplication_service = new SCAService("multiplication_service", self)
		self.add_service multiplication_service
	end
	
	# Définition des méthodes pouvant être appelées par référence
	redef fun receive(operation: String, parameters: nullable List[Parameter]): nullable Object do
		if operation == "fois" then
			return self.fois(parameters[0].value.to_s.to_i, parameters[1].value.to_s.to_i)
		end
		return null
	end
end