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

# Module of commponent context "addition" that contains the SCA specification
# This one is called when receiving a request
module additionContext

import sca
import addition

# Addition component
class AdditionContext
	super SCAComponentImp 
	super Addition
	
	init with_name(name:String) do
		# Add service
		var addition_service = new SCAService("addition_service", self)
		self.add_service addition_service
	end
	
	# Definition of methods that can be called by reference
	redef fun receive(operation: String, parameters: nullable List[Parameter]): nullable Object do
		if operation == "plus" then
			return self.plus(parameters[0].value.to_s.to_i, parameters[1].value.to_s.to_i)
		end
		return null
	end
end