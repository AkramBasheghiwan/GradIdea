// 2. كلاس النصوص (Strings - Arabic RTL)
class AppString {
  AppString._();
  // General
  static const String skip = "تخطي";
  static const String appName = "نظام إدارة مشاريع التخرج";
  static const String appSubTitle = " أفكارك.. بوابتك للمستقبل";
  static const String getStarted = "ابدأ الآن";

  // Screen 1
  static const String title1 = "إدارة متكاملة لمشاريع التخرج";
  static const String body1 =
      "منصة واحدة تجمع الطالب، المشرف، ورئيس القسم لتسهيل رحلة التخرج.";

  // Screen 2
  static const String title2 = "تحقق من فكرتك بالذكاء الاصطناعي";
  static const String body2 =
      "نضمن لك تميز مشروعك وعدم تكراره من خلال محرك بحث ذكي يمسح المشاريع السابقة.";

  // Screen 3
  static const String title3 = "ارفع مشروعك للاعتماد فوراً";
  static const String body3 =
      "مسار مبسط لرفع الملفات والحصول على موافقة رئيس القسم في خطوات معدودة.";

  // Screen 4 (New)
  static const String title4 = "فرص حقيقية من سوق العمل";
  static const String body4 =
      "شركات ومؤسسات تطرح احتياجاتها التقنية.. تبنَّ مشروعاً حقيقياً ليكون بوابتك للتوظيف.";

  static const String onboardingKey = 'onboarding';

  static const String welcomeBack = "مرحباً بك مجدداً";
  static const String emailHint = "البريد الإلكتروني";
  static const String passwordHint = "كلمة المرور";
  static const String login = "تسجيل الدخول";
  static const String forgotPassword = "نسيت كلمة المرور؟";
  static const String noAccount = "ليس لديك حساب؟";
  static const String createAccount = "إنشاء حساب جديد";
  static const String errorLogin = "فشل تسجيل الدخول";
  static const String successLogin = "تم تسجيل الدخول بنجاح";

  static const String requiredField = "هذا الحقل مطلوب";
  static const String invalidEmail = "يرجى إدخال بريد إلكتروني صحيح";
  static const String passwordShort =
      "كلمة المرور يجب أن تكون 8 خانات على الأقل";
  static const String passwordWeak =
      "كلمة المرور يجب أن تحتوي على حرف كبير، حرف صغير، ورقم";
  static const String password = "كلمة المرور";
  static const String email = "البريد الإلكتروني";
  static const String hint = "••••••••";
  static const String emailHinte = "example@gmail.com";
}

class AppStrings {
  // --- GLOBAL (عام) ---
  static const String backToLogin = "الرجوع لتسجيل الدخول";
  static const String appName = "منصة التخرج الذكية";
  static const String betaVersion = "نسخة تجريبية 1.0";
  static const String next = "التالي";
  static const String skip = "تخطي";
  static const String startNow = "ابدأ الآن";
  static const String cancel = "إلغاء";
  static const String confirm = "تأكيد";

  // --- SPLASH & ONBOARDING (البداية) ---
  static const String splashTagline = "أفكارك.. بوابتك للمستقبل";

  static const String onBoardingTitle1 = "إدارة متكاملة لمشاريع التخرج";
  static const String onBoardingDesc1 =
      "منصة واحدة تجمع الطالب، المشرف، ورئيس القسم لتسهيل رحلة التخرج.";

  static const String onBoardingTitle2 = "تحقق من فكرتك بالذكاء الاصطناعي";
  static const String onBoardingDesc2 =
      "نضمن لك تميز مشروعك وعدم تكراره من خلال محرك بحث ذكي يمسح المشاريع السابقة.";

  static const String onBoardingTitle3 = "ارفع مشروعك للاعتماد فوراً";
  static const String onBoardingDesc3 =
      "مسار مبسط لرفع الملفات والحصول على موافقة رئيس القسم في خطوات معدودة.";

  static const String onBoardingTitle4 = "فرص حقيقية من سوق العمل";
  static const String onBoardingDesc4 =
      "شركات ومؤسسات تطرح احتياجاتها التقنية.. تبنَّ مشروعاً حقيقياً ليكون بوابتك للتوظيف.";

  // --- AUTH (المصادقة) ---
  static const String welcomeBack = "مرحباً بك مجدداً";
  static const String loginTitle = "تسجيل الدخول";
  static const String createAccount = "إنشاء حساب جديد";
  static const String joinUs = "انضم إلينا وابدأ رحلتك";
  static const String emailLabel = "البريد الالكنروني";
  static const String passwordLabel = "كلمة المرور";
  static const String forgotPassword = "نسيت كلمة المرور؟";
  static const String dontHaveAccount = "ليس لديك حساب؟";
  static const String nameLabel = "الاسم الرباعي";
  static const String majorLabel = "اختر التخصص";
  static const String alreadyHaveAccount = "لديك حساب بالفعل؟ تسجيل الدخول";

  // --- STUDENT HOME (واجهة الطالب) ---
  static const String helloStudent = "مرحباً، مبدع المستقبل 👋";
  static const String aiCheckerTitle = "اختبر فكرتك بالذكاء الاصطناعي";
  static const String aiCheckerSubtitle = "تحقق من نسبة التشابه فوراً";
  static const String projectArchive = "أرشيف المشاريع";
  static const String uploadProject = "رفع مشروعي";
  static const String currentStatus = "حالة مشروعك: ";
  static const String verifyEmailTitle = "تفعيل الحساب";
  static const String verifyEmailSubTitle =
      "تم إرسال رابط التفعيل إلى بريدك الإلكتروني. يرجى التحقق من صندوق الوارد والضغط على الرابط لتفعيل حسابك.";
  static const String resendEmail = "إعادة إرسال الرابط";
  static const String resendAfter = "إعادة الإرسال بعد ";
  static const String second = " ثانية";
  static const String checkStatus = "تحقق من التفعيل الآن";
  static const String noInternetTitle = "انقطع الاتصال!";
  static const String noInternetSubTitle =
      "يبدو أنك غير متصل بالشبكة، يرجى التحقق من الراوتر أو بيانات الهاتف.";
  static const String tryAgain = "إعادة المحاولة";
  static const String forgotPasswordTitle = "نسيت كلمة المرور؟";
  static const String forgotPasswordSubTitle =
      "لا تقلق، أدخل بريدك الإلكتروني لاستعادة حسابك.";
  static const String universityEmailHint = "البريد الإلكتروني الجامعي";
  static const String sendVerificationCode = "إرسال رمز التحقق";
  static const String usersDirectory = "دليل المستخدمين";
  static const String students = "الطلاب";
  static const String deptHeads = "رؤساء الأقسام";
  static const String externalEntities = "اسم الجهة";
  static const String searchUsers = "ابحث عن اسم، تخصص...";
  static const String welcomeAdmin = "مرحباً، المسؤول";
  static const String systemOverview = "نظرة عامة على النظام";
  static const String totalUsers = "إجمالي المستخدمين";
  static const String deptHeadsCount = "رؤساء الأقسام";
  static const String archivedProjects = "مشاريع مؤرشفة";
  static const String externalEntitiesCount = "الجهات الخارجية";
  static const String quickControl = "التحكم السريع";
  static const String manageUsers = "إدارة المستخدمين";
  static const String projectsArchive = "أرشيف المشاريع";
  static const String uploadTitle = "تقديم المشروع";
  static const String uploadSubTitle =
      "أكمل بيانات مشروعك للحصول على الاعتماد الرسمي.";
  static const String projectName = "اسم المشروع";
  static const String projectDesc = "وصف مختصر للمشروع";
  static const String studentsNames = "أسماء الطلاب المشاركين";
  static const String supervisorName = "اسم المشرف الأكاديمي";
  static const String uploadFile = "ارفع ملف المشروع (PDF/ZIP)";
  static const String submitProject = "إرسال المشروع للمراجعة";
  static const String projectsArchiveTitle = "أرشيف المشاريع";
  static const String computerScience = "علوم الحاسب";
  static const String engineering = "الهندسة";
  static const String businessAdmin = "إدارة الأعمال";
  static const String searchForProject = "ابحث عن عنوان مشروع...";
  static const String advancedSearch = "البحث المتقدم";
  static const String searchInstruction =
      "أدخل بيانات البحث للوصول للمشروع المطلوب";
  static const String projectTitleOptional = "اسم المشروع (اختياري)";
  static const String majorRequired = "التخصص (إجباري)";
  static const String yearRequired = "سنة التخرج (إجباري)";
  static const String searchNow = "بحث في الأرشيف";
  static const String projectDetails = "تفاصيل المشروع";
  static const String aboutProject = "عن المشروع";
  static const String teamMembers = "فريق العمل";
  static const String supervisor = "المشرف الأكاديمي";
  static const String downloadFiles = "تحميل المستندات";
  static const String viewDemo = "عرض العرض التوضيحي";
  static const String phoneNumber = 'رقم الجوال';
  /////////////////////////////////////////////////////////////

  static const String heroTitle = "مدقق الأفكار الذكي";
  static const String heroSubTitle =
      "تحقق من أصالة فكرة مشروع تخرجك وقدرتها على المنافسة باستخدام تقنيات الذكاء الاصطناعي المتقدمة.";

  static const String inputPlaceholder =
      "اكتب فكرتك بالتفصيل هنا للحصول على أفضل نتيجة...";
  static const String checkButton = "فحص الفكرة الآن";
  static const String notesHeader = "ملاحظات هامة للنتائج";
  static const String similarityAnalysis = "تحليل التشابه";
  static const String semiRepeated = "شبه مكررة";
  static const String similarityRatio = "نسبة التشابه";
  static const String improvementTitle = "تحسين الفكرة؟";
  static const String similarProjectsTitle = "مشاريع سابقة مشابهة";
  static const String matchingResults = "3 نتائج مطابقة";
}
