import 'package:pay_buy_max/generated/json/base/json_convert_content.dart';
import 'package:pay_buy_max/generated/json/base/json_field.dart';

class CourseListEntity with JsonConvert<CourseListEntity> {
	bool? status;
	List<CourseListCourses>? courses;
}

class CourseListCourses with JsonConvert<CourseListCourses> {
	String? id;
	String? name;
	@JSONField(name: "course_outlines")
	String? courseOutlines;
	int? price;
	int? discount;
	String? createdAt;
	String? updatedAt;
	dynamic? deletedAt;
}
